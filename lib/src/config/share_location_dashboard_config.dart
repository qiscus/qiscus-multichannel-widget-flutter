import 'dart:convert';

/// Setting share location per app dari dashboard Omnichannel, hasil
/// `GET {baseUrl}/api/v2/share_location_config/{appId}`:
/// `{"data": {"enabled": bool, "provider": "osm"|"google",
/// "google_api_key": string|null}, "status": 200}`.
///
/// Dipakai internal oleh `QLocationMapConfig.dashboard()`. Sengaja hanya
/// bergantung pada `dart:convert` supaya logika parse bisa diuji di luar
/// Flutter. Jangan pernah log [googleApiKey].
class ShareLocationDashboardConfig {
  const ShareLocationDashboardConfig({
    required this.enabled,
    required this.provider,
    this.googleApiKey,
  });

  static const providerOsm = 'osm';
  static const providerGoogle = 'google';

  final bool enabled;

  /// `osm` atau `google` (nilai lain dianggap tidak bisa dipakai).
  final String provider;
  final String? googleApiKey;

  bool get isGoogle => provider == providerGoogle;

  /// Menu "Location" boleh tampil: setting aktif dan provider-nya bisa
  /// dipakai (Google wajib punya key).
  bool get usable {
    if (!enabled) return false;
    if (provider == providerOsm) return true;
    var key = googleApiKey;
    return isGoogle && key != null && key.isNotEmpty;
  }

  /// Parse body respons endpoint publik. `null` bila bentuknya tidak sesuai
  /// kontrak (dianggap gagal fetch → menu tidak tampil).
  static ShareLocationDashboardConfig? parse(String body) {
    Object? json;
    try {
      json = jsonDecode(body);
    } on FormatException {
      return null;
    }
    var data = json is Map ? json['data'] : null;
    if (data is! Map) return null;

    var enabled = data['enabled'];
    if (enabled is! bool) return null;

    var rawProvider = data['provider'];
    var provider =
        rawProvider is String ? rawProvider.trim().toLowerCase() : providerOsm;

    var rawKey = data['google_api_key'];
    var key = rawKey is String ? rawKey.trim() : null;

    return ShareLocationDashboardConfig(
      enabled: enabled,
      provider: provider,
      googleApiKey: key == null || key.isEmpty ? null : key,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ShareLocationDashboardConfig &&
      other.enabled == enabled &&
      other.provider == provider &&
      other.googleApiKey == googleApiKey;

  @override
  int get hashCode => Object.hash(enabled, provider, googleApiKey);

  /// Tanpa key, aman untuk log.
  @override
  String toString() => 'ShareLocationDashboardConfig(enabled: $enabled, '
      'provider: $provider, hasGoogleApiKey: ${googleApiKey != null})';
}
