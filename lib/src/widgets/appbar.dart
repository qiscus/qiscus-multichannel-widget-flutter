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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ref.watch(titleConfigProvider)),
              const QChatRoomStatus(),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Status realtime lawan bicara di header: typing (prioritas) atau presence.
/// Tidak menampilkan apa pun selama presence belum diketahui.
class QChatRoomStatus extends ConsumerWidget {
  const QChatRoomStatus({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isTyping = ref.watch(counterpartTypingProvider).isNotEmpty;
    var presence = ref.watch(counterpartPresenceStatusProvider);

    String? label;
    if (isTyping) {
      label = 'Typing...';
    } else if (presence == QPresenceStatus.online) {
      label = 'Online';
    } else if (presence == QPresenceStatus.offline) {
      label = 'Offline';
    }

    if (label == null) return const SizedBox.shrink();
    return Text(
      label,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    );
  }
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
