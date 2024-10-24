part of 'provider.dart';

@riverpod
FlutterSecureStorage encSharedPreference(EncSharedPreferenceRef _) {
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(
      dataStore: true,
      encryptedSharedPreferences: true,
    ),
  );
}

class StorageKey {
  static const secureSession = 'SECURE_SESSION_DATA';
}
