import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import '../models.dart';
import '../multichannel_provider.dart';
import '../provider.dart';
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
    var isLoadMore = false;
    var lastCountMessage = 0;

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        ref: ref,
        onBack: () => ref.read(onBackBtnTappedProvider).call(context),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              isLoadMore) {
            ref.read(messagesProvider.notifier).loadMoreMessage();
            isLoadMore = false;
          }
          return false;
        },
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: baseBgColor,
                child: QMultichannelConsumer(
                  builder: (context, ref) {
                    var messages = ref.messages;
                    isLoadMore = lastCountMessage < messages.length;

                    if (messages.isEmpty && ref.room.value == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (messages.isEmpty && ref.room.value != null) {
                      return _buildChatEmpty(context, ref);
                    } else {
                      return GroupedListView<QMessage, DateTime>(
                        reverse: true,
                        elements: messages,
                        groupBy: (message) => DateTime.parse(formatDate(
                            message.timestamp, [yyyy, '-', mm, '-', dd])),
                        itemBuilder: (context, message) {
                          return InkWell(
                            child: _buildChatBubble(context, ref, message),
                            onLongPress: () {
                              if (message.type == QMessageType.text) {
                                _showModalBottomSheet(context, ref, message);
                              }
                            },
                          );
                        },
                        itemComparator: (item1, item2) =>
                            item1.timestamp.compareTo(item2.timestamp),
                        floatingHeader: true,
                        useStickyGroupSeparators: true,
                        groupSeparatorBuilder: (DateTime date) {
                          return _buildSeparator(date, ref);
                        },
                        order: GroupedListOrder.DESC,
                      );
                    }
                  },
                ),
              ),
            ),
            QChatForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildSeparator(DateTime date, QMultichannel ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: ref.theme.timeBackgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  formatDate(date, [DD, ', ', dd, ' ', MM, ' ', yyyy]),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ref.theme.timeLabelTextColor,
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

  Widget _buildChatBubble(
    BuildContext context,
    QMultichannel ref,
    QMessage message,
  ) {
    var accountId = ref.account.whenData((v) => v.id);

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

  Widget _buildChatEmpty(BuildContext context, QMultichannel ref) {
    return Container(
      color: ref.theme.emptyBackgroundColor,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "No Message here yet…",
            style: TextStyle(
              color: ref.theme.emptyTextColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Great discussion start from greeting each others first",
            style: TextStyle(
              color: ref.theme.emptyTextColor,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  _showModalBottomSheet(
      BuildContext context, QMultichannel ref, QMessage message) {
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
              visible: message.type == QMessageType.text,
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
            const Padding(padding: EdgeInsets.only(bottom: 16)),
          ],
        );
      },
    );
  }
}
