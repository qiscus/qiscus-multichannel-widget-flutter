part of 'provider.dart';

final qiscusProvider = FutureProvider<QiscusSDK>((ref) async {
  var appId = ref.watch(appIdProvider);
  var baseUrl = ref.watch(sdkBaseUrlProvider);

  var qiscus = QiscusSDK();
  // qiscus.enableDebugMode(enable: true, level: QLogLevel.verbose);

  if (appId != null) {
    await qiscus.setupWithCustomServer(appId, baseUrl: baseUrl);
  }

  return qiscus;
});
