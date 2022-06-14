import 'package:flutter/material.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

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
    leadingWidth: 35,
    // leading: IconButton(
    //   icon: Icon(
    //     Icons.arrow_back,
    //     size: 34,
    //     color: navFgColor,
    //   ),
    //   onPressed: () => onBack?.call(),
    // ),
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: BackButton(
        onPressed: () => onBack?.call(),
      ),
    ),
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
        return Image.network(
          avatarUrl,
          fit: BoxFit.cover,
          height: 44,
          width: 44,
        );
      } else {
        return Image.asset(
          "assets/avatar.png",
          fit: BoxFit.cover,
          height: 44,
          width: 44,
        );
      }
    },
  );
}
