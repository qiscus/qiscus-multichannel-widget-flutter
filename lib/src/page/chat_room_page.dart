import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';
import 'package:qiscus_multichannel_widget/src/models.dart';

import '../multichannel_provider.dart';
import '../provider.dart';
import '../widgets/chat_form.dart';
import '../widgets/chat_system.dart';
import '../widgets/widgets.dart';

class QChatRoomPage extends Page {
  const QChatRoomPage([this.onBack]) : super(key: const ValueKey("RoomPage"));

  final void Function(BuildContext)? onBack;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => QChatRoomScreen(
        onBack: onBack,
      ),
    );
  }
}

class QChatRoomScreen extends ConsumerWidget {
  const QChatRoomScreen({Key? key, this.onBack}) : super(key: key);

  final void Function(BuildContext)? onBack;

  void back(BuildContext context) {
    var navigator = Navigator.of(context);
    if (onBack != null) {
      onBack!(context);
    } else if (navigator.canPop()) {
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final base = appThemeConfigProvider.select((v) => v.baseColor);
    final baseBgColor = ref.watch(base);
    var isLoadMore = false;
    var lastCountMessage = 0;

    return Scaffold(
      appBar: buildAppBar(
        context: context,
        ref: ref,
        onBack: () => back(context),
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

    // print('type: ${message.type} ${message.runtimeType}');

    // if (message.type == QMessageType.custom) {
    //   var type = message.payload;
    // }

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
        return const CircularProgressIndicator();
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
          // const Spacer(),
          // SafeArea(
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: ref.theme.navigationColor,
          //     ),
          //     onPressed: () {
          //       print('re-initiate chat');
          //       ref.initiateChat().then((r) {
          //         print('success initiate chat');
          //         print(r);
          //       }).catchError((ee) {
          //         print('got error');
          //         print(ee);
          //       });
          //     },
          //     child: const Text('Initiate chat'),
          //   ),
          // ),
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
                  Navigator.of(context).pop();
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
