import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
            child: buildAvatar(ref),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(ref.watch(titleConfigProvider)),
        ),
      ],
    ),
  );
}

Widget buildAvatar(WidgetRef ref) {
  var avatarUrl = ref.read(avatarConfigProvider);
  return avatarUrl.maybeWhen(
    editable: (url) => CachedNetworkImage(
      imageUrl: url,
      placeholder: (_, __) => const CircularProgressIndicator(),
      errorWidget: (ctx, _, e) => Image.asset(
        "lib/src/assets/avatar.png",
        fit: BoxFit.cover,
        height: 44,
        width: 44,
        package: 'qiscus_multichannel_widget',
      ),
    ),
    orElse: () => Image.asset(
      "lib/src/assets/avatar.png",
      fit: BoxFit.cover,
      height: 44,
      width: 44,
      package: 'qiscus_multichannel_widget',
    ),
  );
}
