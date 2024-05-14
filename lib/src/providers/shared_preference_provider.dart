part of 'provider.dart';

@riverpod
FlutterSecureStorage encSharedPreference(EncSharedPreferenceRef _) {
  return const FlutterSecureStorage();
}

class StorageKey {
  static const secureSession = 'SECURE_SESSION_DATA';
}
