import 'package:cached_network_image/cached_network_image.dart';
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
      child: CachedNetworkImage(
        imageUrl: avatarUrl,
        height: 40,
        width: 40,
        fit: BoxFit.cover,
        placeholder: (c, s) => const CircularProgressIndicator(),
        errorWidget: (c, s, e) => Image.asset(
          "lib/src/assets/avatar.png",
          fit: BoxFit.cover,
          height: 40,
          width: 40,
          package: 'qiscus_multichannel_widget',
        ),
      ),
    );
  }
}
