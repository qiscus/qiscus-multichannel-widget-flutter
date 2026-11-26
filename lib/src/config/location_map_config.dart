/// Sumber tile peta untuk fitur share location (map picker + bubble lokasi).
enum QMapTileSource {
  /// Server tile publik OpenStreetMap. Gratis, tanpa API key, tapi tunduk
  /// pada https://operations.osmfoundation.org/policies/tiles/.
  openStreetMap,

  /// Google Map Tiles API (2D tiles). Wajib API key milik client sendiri;
  /// pemakaian ditagihkan ke project Google Cloud client.
  google,
}

/// Konfigurasi peta share location, dipasang lewat
/// `QMultichannelProvider(shareLocation: ...)`.
///
/// ```dart
/// // Opsi 1: OpenStreetMap, gratis.
/// shareLocation: const QLocationMapConfig.openStreetMap(),
///
/// // Opsi 2: Google Maps, pakai key milik client.
/// shareLocation: const QLocationMapConfig.google(apiKey: 'AIza...'),
///
/// // Opsi 3: ikuti setting share location di dashboard Omnichannel.
/// shareLocation: const QLocationMapConfig.dashboard(),
/// ```
class QLocationMapConfig {
  /// Opsi 1: tile OpenStreetMap publik (default).
  const QLocationMapConfig.openStreetMap()
      : source = QMapTileSource.openStreetMap,
        fromDashboard = false,
        googleApiKey = null,
        googleMapType = 'roadmap',
        googleLanguage = 'en-US',
        googleRegion = 'ID',
        googleHeaders = const {};

  /// Opsi 2: Google Map Tiles API. [apiKey] wajib milik client (project
  /// Google Cloud dengan billing aktif dan "Map Tiles API" di-enable).
  ///
  /// [headers] diteruskan ke request session dan tile, misalnya
  /// `X-Ios-Bundle-Identifier` / `X-Android-Package` + `X-Android-Cert`
  /// bila key dibatasi per aplikasi.
  const QLocationMapConfig.google({
    required String apiKey,
    String mapType = 'roadmap',
    String language = 'en-US',
    String region = 'ID',
    Map<String, String> headers = const {},
  })  : source = QMapTileSource.google,
        fromDashboard = false,
        googleApiKey = apiKey,
        googleMapType = mapType,
        googleLanguage = language,
        googleRegion = region,
        googleHeaders = headers;

  /// Opsi 3: ikuti setting share location per app di dashboard Omnichannel.
  ///
  /// Widget membaca `GET {baseUrl}/api/v2/share_location_config/{appId}`
  /// (endpoint publik): menu "Location" hanya tampil bila setting-nya
  /// `enabled`, dan sumber peta (OpenStreetMap atau Google dengan key yang
  /// disimpan di dashboard) mengikuti respons itu. Gagal fetch atau
  /// disabled = menu tidak tampil. Hasilnya di-cache di memori per
  /// (baseUrl, appId) dan di-refresh setiap `initiateChat`.
  ///
  /// [mapType], [language], [region] dan [headers] hanya dipakai bila
  /// dashboard memilih Google, sama artinya dengan [QLocationMapConfig.google]
  /// (mis. `X-Ios-Bundle-Identifier` / `X-Android-Package` + `X-Android-Cert`
  /// bila key dibatasi per aplikasi).
  const QLocationMapConfig.dashboard({
    String mapType = 'roadmap',
    String language = 'en-US',
    String region = 'ID',
    Map<String, String> headers = const {},
  })  : source = QMapTileSource.openStreetMap,
        fromDashboard = true,
        googleApiKey = null,
        googleMapType = mapType,
        googleLanguage = language,
        googleRegion = region,
        googleHeaders = headers;

  /// Sumber tile. Untuk [QLocationMapConfig.dashboard] nilai ini hanya
  /// placeholder; sumber sebenarnya ditentukan respons dashboard.
  final QMapTileSource source;

  /// `true` bila dibuat dengan [QLocationMapConfig.dashboard].
  final bool fromDashboard;
  final String? googleApiKey;

  /// `roadmap`, `satellite` atau `terrain` (lihat dokumentasi Map Tiles API).
  final String googleMapType;
  final String googleLanguage;
  final String googleRegion;
  final Map<String, String> googleHeaders;

  bool get isGoogle => source == QMapTileSource.google;

  /// Config efektif dari respons dashboard: Google memakai key dari
  /// dashboard + opsi Google (mapType/language/region/headers) milik config
  /// ini; selain itu OpenStreetMap.
  QLocationMapConfig resolveDashboard({
    required bool google,
    String? googleApiKey,
  }) {
    if (google && googleApiKey != null && googleApiKey.isNotEmpty) {
      return QLocationMapConfig.google(
        apiKey: googleApiKey,
        mapType: googleMapType,
        language: googleLanguage,
        region: googleRegion,
        headers: googleHeaders,
      );
    }
    return const QLocationMapConfig.openStreetMap();
  }

  @override
  bool operator ==(Object other) =>
      other is QLocationMapConfig &&
      other.source == source &&
      other.fromDashboard == fromDashboard &&
      other.googleApiKey == googleApiKey &&
      other.googleMapType == googleMapType &&
      other.googleLanguage == googleLanguage &&
      other.googleRegion == googleRegion &&
      _mapEquals(other.googleHeaders, googleHeaders);

  @override
  int get hashCode => Object.hash(
        source,
        fromDashboard,
        googleApiKey,
        googleMapType,
        googleLanguage,
        googleRegion,
        Object.hashAllUnordered(
          googleHeaders.entries.map((e) => '${e.key}=${e.value}'),
        ),
      );

  static bool _mapEquals(Map<String, String> a, Map<String, String> b) {
    if (a.length != b.length) return false;
    for (var e in a.entries) {
      if (b[e.key] != e.value) return false;
    }
    return true;
  }
}
