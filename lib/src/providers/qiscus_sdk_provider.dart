part of 'provider.dart';

@Riverpod(keepAlive: true)
QiscusSDK qiscusSDK(QiscusSDKRef ref) {
  return QiscusSDK();
}

@Riverpod(keepAlive: true)
Future<QiscusSDK> qiscus(QiscusRef ref) async {
  var qiscus = ref.watch(qiscusSDKProvider);
  var appId = ref.watch(appIdProvider);
  var baseUrl = ref.watch(sdkBaseUrlProvider);

  // qiscus.enableDebugMode(enable: true, level: QLogLevel.verbose);

  if (appId != null) {
    await qiscus.setupWithCustomServer(appId, baseUrl: baseUrl);
  }

  return qiscus;
}
