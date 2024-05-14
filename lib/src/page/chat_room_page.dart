import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import '../models.dart';
import '../provider.dart';
import '../providers/replied_message_provider.dart';
import '../widgets/chat_form.dart';
import '../widgets/chat_system.dart';
import '../widgets/widgets.dart';

class QChatRoomPage extends Page {
  const QChatRoomPage([this.onBack]) : super(key: const ValueKey("RoomPage"));

  @override
  String? get name => 'QChatRoomPage';

  final void Function(BuildContext)? onBack;

  @override
  Route createRoute(BuildContext context) {
    return QChatRoomPageRoute(onBack, settings: this);
  }
}

class QChatRoomPageRoute extends MaterialPageRoute {
  QChatRoomPageRoute(
    this.onBack, {
    super.settings,
    super.fullscreenDialog,
    super.maintainState,
  }) : super(builder: _builder(onBack));

  final OnBackBtnFn? onBack;

  @override
  bool didPop(result) {
    var context = subtreeContext!;

    if (isCurrent || !isFirst) onBack?.call(context);

    return super.didPop(result);
  }

  static Widget Function(BuildContext) _builder(OnBackBtnFn? onBack) =>
      (context) => QChatRoomScreen(onBack: onBack);
}

class QChatRoomScreen extends ConsumerStatefulWidget {
  const QChatRoomScreen({super.key, this.onBack});
  final OnBackBtnFn? onBack;

  @override
  ConsumerState<QChatRoomScreen> createState() => QChatRoomScreenState();
}

class QChatRoomScreenState extends ConsumerState<QChatRoomScreen> {
  QChatRoomScreenState();

  late final void Function(BuildContext)? onBack = widget.onBack;

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      if (onBack != null) {
        ref.read(onBackBtnTappedProvider.notifier).state = onBack!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final base = appThemeConfigProvider.select((v) => v.baseColor);
    final baseBgColor = ref.watch(base);
    var isAbleToLoadMore = false;
    var lastCountMessage = 0;

    var messages = ref.watch(mappedMessagesProvider);
    isAbleToLoadMore = lastCountMessage < messages.length;
    var room =
        ref.watch(roomProvider.select((v) => v.whenData((v) => v.room).value));

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        ref: ref,
        onBack: () => ref.read(onBackBtnTappedProvider).call(context),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              isAbleToLoadMore) {
            ref.read(messagesNotifierProvider.notifier).loadMoreMessage();
            isAbleToLoadMore = false;
          }
          return false;
        },
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: baseBgColor,
                child: buildMessageList(messages, room),
              ),
            ),
            QChatForm(),
          ],
        ),
      ),
    );
  }

  Widget buildMessageList(
    List<QMessage> messages,
    QChatRoom? room,
  ) {
    if (messages.isEmpty && room == null) {
      return const Center(child: CircularProgressIndicator());
    } else if (messages.isEmpty && room != null) {
      return _buildChatEmpty();
    } else {
      return GroupedListView<QMessage, DateTime>(
        reverse: true,
        elements: messages,
        groupBy: (message) => _buildGroupList(message),
        itemBuilder: (context, message) {
          return InkWell(
            child: _buildChatBubble(message),
            onLongPress: () {
              _showModalBottomSheet(message);
            },
          );
        },
        itemComparator: (item1, item2) =>
            item1.timestamp.compareTo(item2.timestamp),
        floatingHeader: true,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (DateTime date) {
          return _buildSeparator(date);
        },
        order: GroupedListOrder.DESC,
      );
    }
  }

  DateTime _buildGroupList(QMessage message) {
    return DateTime.parse(
        formatDate(message.timestamp, [yyyy, '-', mm, '-', dd]));
  }

  Widget _buildSeparator(DateTime date) {
    var theme = ref.watch(appThemeConfigProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: theme.timeBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  formatDate(date, [DD, ', ', dd, ' ', MM, ' ', yyyy]),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.timeLabelTextColor,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChatBubble(QMessage message) {
    var accountId = ref
        .watch(accountProvider.select((v) => v.whenData((value) => value.id)));

    if (message is QMessageSystem) {
      return QChatSystem(message: message);
    }

    return accountId.when(
      data: (accountId) {
        if (message.sender.id == accountId) {
          return QChatBubbleRight(message: message);
        } else {
          return QChatBubbleLeft(message: message);
        }
      },
      loading: () {
        return const QChatBubbleRightEmpty();
      },
      error: (e, _) {
        return Text(e.toString());
      },
    );
  }

  Widget _buildChatEmpty() {
    var theme = ref.watch(appThemeConfigProvider);
    return Container(
      color: theme.emptyBackgroundColor,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "No Message here yet…",
            style: TextStyle(
              color: theme.emptyTextColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Great discussion start from greeting each others first",
            style: TextStyle(
              color: theme.emptyTextColor,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  _showModalBottomSheet(QMessage message) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return Wrap(
          spacing: 2,
          children: [
            const Padding(padding: EdgeInsets.only(top: 16)),
            Visibility(
              visible: message.type == QMessageType.text ||
                  message.type == QMessageType.reply,
              child: ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('Copy Message'),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: message.text));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Message copied"),
                  ));
                  Navigator.of(context).maybePop();
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.reply),
              title: const Text('Reply'),
              onTap: () {
                ref.read(repliedMessageProvider.notifier).state = message;
                Navigator.of(context).maybePop();
              },
            ),
            const Padding(padding: EdgeInsets.only(bottom: 16)),
          ],
        );
      },
    );
  }
}
