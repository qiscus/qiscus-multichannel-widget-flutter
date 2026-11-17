part of 'provider.dart';

@riverpod
FlutterSecureStorage encSharedPreference(EncSharedPreferenceRef _) {
  // Upstream flutter_secure_storage (>=9.2.4 <11). Android memakai file prefs
  // sendiri supaya tidak bercampur dengan data/opsi cipher secure storage
  // milik host app (plugin yang sama). `sharedPreferencesName` ada di 9.x dan
  // 10.x; `storageNamespace` penggantinya baru ada di 10.x.
  return const FlutterSecureStorage(
    aOptions: AndroidOptions(
      // ignore: deprecated_member_use
      sharedPreferencesName: 'QiscusMultichannelSecureStorage',
    ),
  );
}

class StorageKey {
  /// Key lama (global, bukan per-channel) yang dipakai sebelum fix
  /// session-per-channel. Hanya dibaca sekali untuk migrasi lalu dihapus
  /// (lihat [migrateLegacySecureSession]) — jangan pernah ditulis lagi.
  static const legacySecureSessionKey = 'SECURE_SESSION_DATA';

  static String getSecureSessionKey({
    required String appId,
    String? channelId = 'unknown_channel_id',
    String? userId = 'unknown_user_id',
  }) =>
      'Qiscus_Key:$appId:$channelId:$userId';
}

/// Migrasi satu kali dari [StorageKey.legacySecureSessionKey] (key global
/// pra-fix session-per-channel) ke [sessionKey] (key baru, per
/// appId+channelId+userId), kalau isinya memang cocok dengan channel/user
/// yang sedang aktif saat ini.
///
/// Key lama selalu dihapus setelah dicek sekali — baik cocok maupun tidak —
/// supaya tidak "nyangkut" di storage dan berisiko salah dikonsumsi channel
/// lain nantinya. Seluruh proses ini best-effort: kegagalan apa pun di sini
/// tidak boleh menghalangi initiateChat untuk tetap jalan.
Future<void> migrateLegacySecureSession({
  required FlutterSecureStorage storage,
  required String sessionKey,
  required String appId,
  String? channelId,
  String? userId,
}) async {
  try {
    // Sudah ada sesi per-channel sendiri (dari migrasi sebelumnya atau dari
    // initiateChat normal) -> tidak perlu migrasi lagi.
    var alreadyMigrated = await storage.read(key: sessionKey);
    if (alreadyMigrated != null) return;

    var legacyRaw = await storage.read(key: StorageKey.legacySecureSessionKey);
    if (legacyRaw == null) return;

    try {
      var legacyJson = jsonDecode(legacyRaw) as Map<String, dynamic>;
      var legacySession = SecureSession.fromJson(legacyJson);

      if (legacySession.appId == appId &&
          legacySession.channelId == channelId &&
          legacySession.userId == userId) {
        await storage.write(key: sessionKey, value: legacyRaw);
      }
    } catch (_) {
      // Data lama korup / format tak dikenal -> abaikan, tetap dihapus di
      // bawah supaya tidak dicoba lagi di initiateChat berikutnya.
    }

    await storage.delete(key: StorageKey.legacySecureSessionKey);
  } catch (_) {
    // Best-effort: kegagalan migrasi tidak boleh menghalangi initiateChat.
  }
}
