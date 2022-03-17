import 'package:flutter/material.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

AppBar buildAppBar({
  required BuildContext context,
  required QChatRoom room,
}) {
  return AppBar(
    centerTitle: false,
    elevation: 2,
    leading: TextButton(
      onPressed: () {},
      child: Icon(
        Icons.arrow_back,
        size: 34,
        color: Theme.of(context).appBarTheme.iconTheme?.color ?? Colors.white,
      ),
    ),
    title: Row(
      children: [
        SizedBox.square(
          dimension: 44,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: room.avatarUrl != null
                ? Image.network(
                    room.avatarUrl!,
                    fit: BoxFit.cover,
                    height: 44,
                    width: 44,
                  )
                : Image.asset(
                    "assets/avatar.png",
                    fit: BoxFit.cover,
                    height: 44,
                    width: 44,
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(room.name ?? 'Room name'),
        ),
      ],
    ),
  );
}
