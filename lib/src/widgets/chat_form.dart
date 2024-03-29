import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../multichannel_provider.dart';
import '../provider.dart';
import '../utils/colors.dart';

class QChatForm extends ConsumerWidget {
  QChatForm({
    Key? key,
  }) : super(key: key);

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var files = ref.watch(uploaderProvider);

    var isResolved = ref.watch(isResolvedProvider);
    if (isResolved) {
      return Container();
    }

    return Column(
      children: [
        for (var file in files) _buildUploadIndicatorItem(file, ref),
        Container(
          decoration: BoxDecoration(
            color: "#fafafa".toColor(),
            border: Border(
              top: BorderSide(width: 1, color: "#e3e3e3".toColor()),
            ),
          ),
          child: QMultichannelConsumer(
            builder: (context, QMultichannel mulchan) {
              var account = mulchan.account;
              var borderColor = mulchan.theme.fieldChatBorderColor;
              var theme = mulchan.theme;

              final border = OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: borderColor),
              );

              return Container(
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
                                onSubmitted: (_) => _onSubmit(mulchan),
                                decoration: InputDecoration(
                                  hintText: 'Your message here...',
                                  disabledBorder: border,
                                  enabledBorder: border,
                                  focusedBorder: border,
                                ),
                                style: TextStyle(
                                  color: mulchan.theme.fieldChatTextColor,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => _onSubmit(mulchan),
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
              );
            },
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
                ref.read(uploaderProvider.notifier).cancel(file);
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

  void _onSubmit(QMultichannel ref) async {
    var text = _messageController.text;
    if (text.trim().isNotEmpty) {
      var message = await ref.generateMessage(text: text);
      await ref.sendMessage(message);
      _messageController.clear();
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
      ref.read(uploaderProvider.notifier).add(file);
    }
  }
}
