import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

class RichLinkText extends ConsumerWidget {
  final String text;
  final QUser sender;

  const RichLinkText({
    Key? key,
    required this.text,
    required this.sender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    onTap(String url) => ref.watch(onURLTappedProvider)?.call(url);

    return QMultichannelConsumer(
      builder: (context, ref) {
        final fgColor = _getFgColor(ref);
        return generateRichLinkText(
          text: text,
          onTap: onTap,
          fgColor: fgColor,
        );
      },
    );
  }

  Color _getFgColor(QMultichannel ref) {
    final account = ref.account.value!;
    if (account.id == sender.id) {
      return ref.theme.rightBubbleTextColor;
    } else {
      return ref.theme.leftBubbleTextColor;
    }
  }
}

RichText generateRichLinkText({
  required String text,
  required void Function(String url) onTap,
  required Color fgColor,
}) {
  final urlRe = RegExp(
      r'(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,4}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)');

  var res = urlRe.allMatches(text);
  var indexed = [];
  var splittedRes = <TextSpan>[];
  var lastReadIndex = 0;
  var textStyle = TextStyle(
    color: fgColor,
  );
  var linkStyle = TextStyle(
    color: fgColor,
    decoration: TextDecoration.underline,
  );

  for (var r in res) {
    indexed.add([r.start, r.end]);
  }

  if (indexed.isEmpty) {
    return RichText(
      text: TextSpan(
        text: text,
        style: textStyle,
      ),
    );
  }

  for (var index in indexed) {
    var start = index[0];
    var end = index[1];

    if (lastReadIndex < start) {
      var r = text.substring(lastReadIndex, start);
      splittedRes.add(TextSpan(
        text: r,
        style: textStyle,
      ));
    }

    var r = text.substring(start, end);
    splittedRes.add(TextSpan(
      text: r,
      style: linkStyle,
      recognizer: TapGestureRecognizer()..onTap = () => onTap(r),
    ));
    lastReadIndex = end;
  }

  return RichText(
    text: TextSpan(
      children: splittedRes,
    ),
  );
}
