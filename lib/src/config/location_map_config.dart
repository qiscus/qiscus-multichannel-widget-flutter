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
/// ```
class QLocationMapConfig {
  /// Opsi 1: tile OpenStreetMap publik (default).
  const QLocationMapConfig.openStreetMap()
      : source = QMapTileSource.openStreetMap,
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
        googleApiKey = apiKey,
        googleMapType = mapType,
        googleLanguage = language,
        googleRegion = region,
        googleHeaders = headers;

  final QMapTileSource source;
  final String? googleApiKey;

  /// `roadmap`, `satellite` atau `terrain` (lihat dokumentasi Map Tiles API).
  final String googleMapType;
  final String googleLanguage;
  final String googleRegion;
  final Map<String, String> googleHeaders;

  bool get isGoogle => source == QMapTileSource.google;

  @override
  bool operator ==(Object other) =>
      other is QLocationMapConfig &&
      other.source == source &&
      other.googleApiKey == googleApiKey &&
      other.googleMapType == googleMapType &&
      other.googleLanguage == googleLanguage &&
      other.googleRegion == googleRegion &&
      _mapEquals(other.googleHeaders, googleHeaders);

  @override
  int get hashCode => Object.hash(
        source,
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
