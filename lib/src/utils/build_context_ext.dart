import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import '../bloc/app_bloc.dart';
import '../states/app_state.dart';

extension QBuildContextExt on BuildContext {
  QiscusSDK qiscus() {
    return select((QAppBloc bloc) => bloc.qiscus);
  }

  QAccount? account() {
    return select((QAppBloc bloc) => bloc.state.mapOrNull(
          ready: (v) => v.account,
        ));
  }

  QChatRoom? room() {
    return select((QAppBloc bloc) => bloc.state.mapOrNull(
          ready: (v) => v.room,
        ));
  }

  List<QMessage> messages() {
    return select((QAppBloc bloc) => bloc.state.maybeMap(
          orElse: () => [],
          ready: (v) => v.messages,
        ));
  }
}
