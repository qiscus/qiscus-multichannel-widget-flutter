part of 'provider.dart';

/// Konfigurasi share location dari `QMultichannelProvider(shareLocation:)`.
/// `null` (default) = fitur mati, agar app konsumen yang upgrade tidak
/// tiba-tiba butuh izin lokasi / purpose string iOS. Non-null = menu
/// "Location" aktif dengan sumber peta sesuai config (OSM atau Google), atau
/// mengikuti dashboard bila [QLocationMapConfig.dashboard].
///
/// Ini config yang *diminta* host app; widget membaca
/// [effectiveLocationMapConfigProvider].
final locationMapConfigProvider = StateProvider<QLocationMapConfig?>(
  (_) => null,
  name: 'locationMapConfigProvider',
);

/// Setting share location dari dashboard (endpoint publik), hanya di-fetch
/// bila `shareLocation` = [QLocationMapConfig.dashboard]. `null` = bukan mode
/// dashboard, appId belum ada, atau fetch gagal (menu tidak tampil).
final shareLocationDashboardConfigProvider =
    FutureProvider<ShareLocationDashboardConfig?>(
  (ref) async {
    var requested = ref.watch(locationMapConfigProvider);
    if (requested == null || !requested.fromDashboard) return null;
    var baseUrl = ref.watch(baseUrlProvider);
    var appId = ref.watch(appIdProvider);
    if (appId == null || appId.isEmpty) return null;
    return _ShareLocationConfigCache.get(baseUrl, appId);
  },
  name: 'shareLocationDashboardConfigProvider',
);

/// Config peta yang benar-benar dipakai widget (menu, picker, bubble):
/// - `shareLocation` null → null (fitur mati);
/// - `openStreetMap()` / `google()` → apa adanya;
/// - `dashboard()` → hasil setting dashboard bila `enabled` dan bisa dipakai,
///   selain itu (disabled, gagal fetch, masih loading pertama kali) null.
final effectiveLocationMapConfigProvider = Provider<QLocationMapConfig?>(
  (ref) {
    var requested = ref.watch(locationMapConfigProvider);
    if (requested == null || !requested.fromDashboard) return requested;

    // valueOrNull tetap berisi nilai lama saat refresh (initiateChat), jadi
    // menu tidak berkedip.
    var remote = ref.watch(shareLocationDashboardConfigProvider).valueOrNull;
    if (remote == null || !remote.usable) return null;
    return requested.resolveDashboard(
      google: remote.isGoogle,
      googleApiKey: remote.googleApiKey,
    );
  },
  name: 'effectiveLocationMapConfigProvider',
);

/// Menu "Location" tampil hanya bila ada config efektif.
final locationEnabledProvider = Provider<bool>(
  (ref) => ref.watch(effectiveLocationMapConfigProvider) != null,
  name: 'locationEnabledProvider',
);

/// Tandai setting dashboard basi lalu minta provider membacanya ulang.
/// Dipanggil di awal `initiateChat`; sinkron supaya aman dipanggil dari ref
/// provider autoDispose. Tidak melakukan apa pun bila bukan mode dashboard.
void refreshShareLocationDashboardConfig(Ref ref) {
  var requested = ref.read(locationMapConfigProvider);
  if (requested == null || !requested.fromDashboard) return;
  var appId = ref.read(appIdProvider);
  if (appId == null || appId.isEmpty) return;
  _ShareLocationConfigCache.markStale(ref.read(baseUrlProvider), appId);
  ref.invalidate(shareLocationDashboardConfigProvider);
}

/// Cache memori setting dashboard per (baseUrl, appId), dipakai bersama oleh
/// semua `QMultichannelProvider` di proses yang sama. Request yang sedang
/// berjalan untuk key yang sama digabung.
class _ShareLocationConfigCache {
  static final _values = <String, ShareLocationDashboardConfig>{};
  static final _stale = <String>{};
  static final _inFlight = <String, Future<ShareLocationDashboardConfig?>>{};

  static String _key(String baseUrl, String appId) =>
      '${_trimBaseUrl(baseUrl)}|$appId';

  static void markStale(String baseUrl, String appId) {
    _stale.add(_key(baseUrl, appId));
  }

  static Future<ShareLocationDashboardConfig?> get(
    String baseUrl,
    String appId,
  ) {
    var key = _key(baseUrl, appId);
    var cached = _values[key];
    if (cached != null && !_stale.contains(key)) return Future.value(cached);

    var pending = _inFlight[key];
    if (pending != null) return pending;

    _stale.remove(key);
    var future = _fetchShareLocationConfig(baseUrl, appId).then((fresh) {
      if (fresh != null) _values[key] = fresh;
      // Refresh gagal: pakai nilai terakhir yang berhasil (bila ada).
      return fresh ?? _values[key];
    }).whenComplete(() {
      // Blok (bukan `=>`): remove() mengembalikan future ini sendiri, dan
      // whenComplete akan menunggunya → deadlock.
      _inFlight.remove(key);
    });
    _inFlight[key] = future;
    return future;
  }
}

String _trimBaseUrl(String baseUrl) => baseUrl.replaceAll(RegExp(r'/+$'), '');

/// `GET {baseUrl}/api/v2/share_location_config/{appId}` (publik, tanpa auth).
/// `null` bila gagal; respons tidak pernah di-log karena berisi key.
Future<ShareLocationDashboardConfig?> _fetchShareLocationConfig(
  String baseUrl,
  String appId,
) async {
  var uri = Uri.parse(
    '${_trimBaseUrl(baseUrl)}/api/v2/share_location_config/'
    '${Uri.encodeComponent(appId)}',
  );
  try {
    var response = await http.get(
      uri,
      headers: {'Accept': 'application/json'},
    ).timeout(const Duration(seconds: 15));
    if (response.statusCode != 200) {
      debugPrint(
        '[QMultichannel] share_location_config failed '
        '(HTTP ${response.statusCode}); Location menu hidden',
      );
      return null;
    }
    var config = ShareLocationDashboardConfig.parse(response.body);
    if (config == null) {
      debugPrint(
        '[QMultichannel] share_location_config returned an unexpected '
        'response; Location menu hidden',
      );
    }
    return config;
  } catch (e) {
    debugPrint(
      '[QMultichannel] share_location_config failed (${e.runtimeType}); '
      'Location menu hidden',
    );
    return null;
  }
}

/// Hasil `post_comment` yang dipakai untuk meng-update pesan optimistic.
class _PostedComment {
  const _PostedComment({required this.id, required this.status});

  final int id;
  final QMessageStatus status;
}

/// Pesan lokal (optimistic) untuk [location]: `QMessageType.custom` dengan
/// payload server + `type: location`, sama dengan bentuk hasil parse SDK
/// untuk pesan lokasi masuk, sehingga echo realtime (uniqueId sama)
/// menggantikan entri ini alih-alih menduplikasi.
QMessage _generateLocationMessage(
  QiscusSDK qiscus,
  int roomId,
  QLocation location,
) {
  var message = qiscus.generateMessage(
    chatRoomId: roomId,
    text: QLocation.messageText,
  );
  message.type = QMessageType.custom;
  message.payload = location.toMessagePayload();
  message.status = QMessageStatus.sending;
  return message;
}

/// `qiscus_chat_sdk` tidak bisa mengirim comment ber-type `location`
/// (`QMessageType` hanya text/custom/attachment/reply), jadi widget mengirim
/// sendiri ke endpoint REST yang sama dengan SDK.
Future<_PostedComment> _postLocationComment({
  required String sdkBaseUrl,
  required QiscusSDK qiscus,
  required QMessage message,
  required QLocation location,
}) async {
  var appId = qiscus.appId;
  var token = qiscus.token;
  var userId = qiscus.currentUser?.id;
  if (appId == null || token == null || userId == null) {
    throw StateError('QiscusSDK is not logged in');
  }

  var baseUrl = sdkBaseUrl.replaceAll(RegExp(r'/+$'), '');
  var uri = Uri.parse('$baseUrl/api/v2/mobile/post_comment');
  var body = location.toPostCommentBody(
    roomId: message.chatRoomId,
    uniqueId: message.uniqueId,
  );

  var response = await http
      .post(
        uri,
        headers: {
          'qiscus-sdk-app-id': appId,
          'qiscus-sdk-token': token,
          'qiscus-sdk-user-id': userId,
          'content-type': 'application/json',
        },
        body: jsonEncode(body),
      )
      .timeout(const Duration(seconds: 30));

  if (response.statusCode < 200 || response.statusCode >= 300) {
    throw http.ClientException(
      'post_comment failed with HTTP ${response.statusCode}',
      uri,
    );
  }

  return _parsePostedComment(response.body);
}

_PostedComment _parsePostedComment(String responseBody) {
  var json = jsonDecode(responseBody);
  var results = json is Map ? json['results'] : null;
  var comment = results is Map ? results['comment'] : null;
  var id = comment is Map ? comment['id'] : null;
  if (id is! num) {
    throw const FormatException('post_comment response has no comment id');
  }

  var rawStatus = (comment as Map)['status'];
  var status = QMessageStatus.sent;
  if (rawStatus == 'read') status = QMessageStatus.read;
  if (rawStatus == 'delivered') status = QMessageStatus.delivered;
  return _PostedComment(id: id.toInt(), status: status);
}

/// Status pesan setelah POST gagal, atau null bila pesan sebaiknya dihapus
/// dari list. `QMessageStatus.failed` hanya ada di qiscus_chat_sdk >= 2.2
/// (constraint widget masih `^2.1.1`), jadi dicari lewat nama; tanpa itu
/// pesan dihapus agar tidak `sending` selamanya.
final QMessageStatus? _locationFailedStatus = QMessageStatus.values
    .cast<QMessageStatus?>()
    .firstWhere((s) => s!.name == 'failed', orElse: () => null);

void _logLocationError(Object error) {
  debugPrint('[QMultichannel] sendLocationMessage failed: $error');
}

/// Session Google Map Tiles API (`POST /v1/createSession`). Satu session
/// dipakai bersama oleh picker dan semua bubble lokasi.
class QGoogleTileSession {
  const QGoogleTileSession({required this.session, required this.expiresAt});

  final String session;
  final DateTime expiresAt;

  /// Dianggap kedaluwarsa 1 jam lebih awal supaya tidak putus di tengah jalan.
  bool get isExpired =>
      DateTime.now().isAfter(expiresAt.subtract(const Duration(hours: 1)));
}

final googleTileSessionProvider =
    FutureProvider.family<QGoogleTileSession, QLocationMapConfig>(
  (ref, config) async {
    var key = config.googleApiKey;
    if (!config.isGoogle || key == null || key.isEmpty) {
      throw StateError('Google map tiles need an API key');
    }

    var uri = Uri.https('tile.googleapis.com', '/v1/createSession', {
      'key': key,
    });
    var response = await http
        .post(
          uri,
          headers: {
            ...config.googleHeaders,
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'mapType': config.googleMapType,
            'language': config.googleLanguage,
            'region': config.googleRegion,
          }),
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      // Jangan log key; cukup status + pesan error dari Google.
      debugPrint(
        'qiscus_multichannel_widget: Google createSession failed '
        '(${response.statusCode}): ${response.body}',
      );
      throw StateError('Google createSession failed: ${response.statusCode}');
    }

    var json = jsonDecode(response.body) as Map<String, dynamic>;
    var session = json['session'] as String?;
    if (session == null || session.isEmpty) {
      throw StateError('Google createSession returned no session');
    }
    var expirySeconds = int.tryParse('${json['expiry']}');
    var expiresAt = expirySeconds != null
        ? DateTime.fromMillisecondsSinceEpoch(expirySeconds * 1000)
        : DateTime.now().add(const Duration(days: 13));
    return QGoogleTileSession(session: session, expiresAt: expiresAt);
  },
  name: 'googleTileSessionProvider',
);
