import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../multichannel_provider.dart';
import '../provider.dart';

AppBar buildAppBar({
  required BuildContext context,
  required WidgetRef ref,
  void Function()? onBack,
}) {
  var r1 = appThemeConfigProvider.select((v) => v.navigationColor);
  var r2 = appThemeConfigProvider.select((v) => v.navigationTitleColor);
  var navBgColor = ref.watch(r1);
  var navFgColor = ref.watch(r2);

  return AppBar(
    centerTitle: false,
    elevation: 2,
    backgroundColor: navBgColor,
    foregroundColor: navFgColor,
    leadingWidth: 55,
    leading: Padding(
      padding: const EdgeInsets.all(1.0),
      child: BackButton(
        onPressed: () => onBack?.call(),
      ),
    ),
    titleSpacing: 0,
    title: Row(
      children: [
        SizedBox.square(
          dimension: 44,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: buildAvatar(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: QMultichannelConsumer(
            builder: (context, ref) {
              // var roomName = ref.room.whenOrNull(data: (v) => v.name);
              var title = ref.title;

              return Text(title);
            },
          ),
        ),
      ],
    ),
  );
}

Widget buildAvatar() {
  return QMultichannelConsumer(
    builder: (context, QMultichannel ref) {
      var avatarUrl = ref.avatarUrl;

      if (avatarUrl != null) {
        return CachedNetworkImage(
          imageUrl: avatarUrl,
          placeholder: (_, __) => const CircularProgressIndicator(),
          errorWidget: (ctx, _, e) => Image.asset(
            "lib/src/assets/avatar.png",
            fit: BoxFit.cover,
            height: 44,
            width: 44,
            package: 'qiscus_multichannel_widget',
          ),
        );
      } else {
        return Image.asset(
          "lib/src/assets/avatar.png",
          fit: BoxFit.cover,
          height: 44,
          width: 44,
          package: 'qiscus_multichannel_widget',
        );
      }
    },
  );
}
