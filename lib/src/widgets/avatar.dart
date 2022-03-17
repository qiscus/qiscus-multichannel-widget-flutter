import 'package:flutter/material.dart';

class QAvatar extends StatelessWidget {
  const QAvatar({
    Key? key,
    required this.avatarUrl,
  }) : super(key: key);
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
        avatarUrl,
        height: 40,
        width: 40,
      ),
    );
  }
}
