part of 'provider.dart';

final encSharedPreferenceProvider = Provider((_) {
  return const FlutterSecureStorage();
}, name: 'encSharedPreferenceProvider');

class StorageKey {
  static const secureSession = 'SECURE_SESSION_DATA';
}
