part of 'provider.dart';

final qiscusProvider = FutureProvider<QiscusSDK>((ref) async {
  var appId = ref.watch(appIdProvider);

  var qiscus = QiscusSDK();
  // qiscus.enableDebugMode(enable: true);

  if (appId != null) {
    await qiscus.setup(appId);
  }

  return qiscus;
});
