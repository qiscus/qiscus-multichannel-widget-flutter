import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import '../provider.dart';
import '../providers/replied_message_provider.dart';
import '../utils/colors.dart';

class QChatForm extends ConsumerWidget {
  QChatForm({
    Key? key,
  }) : super(key: key);

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var files = ref.watch(uploadNotifierProvider);

    var isResolved = ref.watch(isResolvedProvider);
    if (isResolved) {
      return Container();
    }

    var theme = ref.watch(appThemeConfigProvider);
    var replyBgColor = theme.replyBackgroundColor;
    var replyTopBorderColor = theme.replyContainerTopBorderColor;
    var replyLeftBorderColor = theme.replyContainerLeftBorderColor;
    var replyFgColor = theme.replyTextColor;
    var borderColor = theme.fieldChatBorderColor;

    var repliedComment = ref.watch(repliedMessageProvider);
    var accountName =
        ref.watch(accountProvider.select((v) => v.asData?.value.name));

    var account = ref.watch(accountProvider);

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: borderColor),
    );

    return Column(
      children: [
        for (var file in files) _buildUploadIndicatorItem(file, ref),
        if (repliedComment != null)
          Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              color: replyBgColor,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: replyTopBorderColor,
                ),
                left: BorderSide(width: 4, color: replyLeftBorderColor),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          repliedComment.sender.name == accountName
                              ? 'You'
                              : repliedComment.sender.name,
                          style: TextStyle(
                            color: replyLeftBorderColor,
                            fontSize: 11,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            repliedComment.text,
                            style: TextStyle(
                              color: replyFgColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(repliedMessageProvider.notifier).state = null;
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: "#fafafa".toColor(),
            border: Border(
              top: BorderSide(width: 1, color: "#e3e3e3".toColor()),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            color: theme.sendContainerBackgroundColor,
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      TextButton(
                        onPressed: () async {
                          showModalBottomSheet(
                            context: context,
                            builder: (c) => _modalBottomSheet(c, ref),
                            isDismissible: true,
                            // isScrollControlled: true,
                            elevation: 2,
                          );
                        },
                        child: Image.asset(
                          'lib/src/assets/ic-add.png',
                          package: 'qiscus_multichannel_widget',
                          color: theme.sendContainerColor,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: TextField(
                            enabled: account.hasValue,
                            controller: _messageController,
                            onSubmitted: (_) => _onSubmit(
                              ref,
                              repliedMessage: repliedComment,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Your message here...',
                              disabledBorder: border,
                              enabledBorder: border,
                              focusedBorder: border,
                            ),
                            style: TextStyle(
                              color: theme.fieldChatTextColor,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _onSubmit(
                          ref,
                          repliedMessage: repliedComment,
                        ),
                        child: Image.asset(
                          'lib/src/assets/ic-send.png',
                          package: 'qiscus_multichannel_widget',
                          color: theme.sendContainerColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadIndicatorItem(QUpload file, WidgetRef ref) {
    return Container(
      color: Colors.grey[200],
      height: 55,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Expanded(child: Text(file.file.uri.pathSegments.last)),
            TextButton(
              onPressed: () {
                ref.read(uploadNotifierProvider.notifier).cancel(file);
              },
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  const Icon(Icons.close, color: Colors.black),
                  CircularProgressIndicator(
                    value: file.progress,
                    strokeWidth: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit(WidgetRef ref, {QMessage? repliedMessage}) async {
    var text = _messageController.text;

    if (text.trim().isEmpty) return;

    QMessage message;
    if (repliedMessage != null) {
      message = await ref.read(QMultichannel.provider).generateReplyMessage(
            text: text,
            repliedMessage: repliedMessage,
          );
    } else {
      message =
          await ref.read(QMultichannel.provider).generateMessage(text: text);
    }

    await ref.read(QMultichannel.provider).sendMessage(message);
    _messageController.clear();
    if (repliedMessage != null) {
      ref.read(repliedMessageProvider.notifier).state = null;
    }
  }

  Widget _modalBottomSheet(BuildContext context, WidgetRef ref) {
    var iconColor = const Color.fromARGB(255, 85, 178, 154);
    var textColor = Colors.black87;

    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Column(
          // direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(10),
                  alignment: Alignment.centerLeft,
                ),
                icon: Icon(
                  Icons.image,
                  color: iconColor,
                ),
                label: Text(
                  'Image',
                  style: TextStyle(color: textColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  FilePicker.platform
                      .pickFiles(type: FileType.image)
                      .then((v) => _fileChoosed(v, ref));
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  minimumSize: const Size.fromHeight(10),
                  alignment: Alignment.centerLeft,
                ),
                icon: Icon(
                  Icons.attach_file,
                  color: iconColor,
                ),
                label: Text(
                  'File',
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  FilePicker.platform
                      .pickFiles(type: FileType.any)
                      .then((v) => _fileChoosed(v, ref));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fileChoosed(FilePickerResult? value, WidgetRef ref) {
    if (value == null) return;
    var files = value.files
        .where((v) => v.path != null)
        .map((v) => File(v.path!))
        .toList();

    for (var file in files) {
      ref.read(uploadNotifierProvider.notifier).add(file);
    }
  }
}
