import 'package:flutter/material.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

class QChatImage extends StatelessWidget {
  const QChatImage({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print("got url: $url");

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: size.width * 0.6,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.network(
                url,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
