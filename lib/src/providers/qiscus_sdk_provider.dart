import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart';

import 'states_provider.dart';

final qiscusProvider = FutureProvider<QiscusSDK>((ref) async {
  var appId = ref.watch(appIdProvider);
  if (appId == null) return QiscusSDK();
  return QiscusSDK.withAppId(appId);
});
