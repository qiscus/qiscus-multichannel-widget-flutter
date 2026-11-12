part of 'provider.dart';

/// Konfigurasi share location dari `QMultichannelProvider(shareLocation:)`.
/// `null` (default) = fitur mati, agar app konsumen yang upgrade tidak
/// tiba-tiba butuh izin lokasi / purpose string iOS. Non-null = menu
/// "Location" aktif dengan sumber peta sesuai config (OSM atau Google).
final locationMapConfigProvider = StateProvider<QLocationMapConfig?>(
  (_) => null,
  name: 'locationMapConfigProvider',
);

/// Menu "Location" tampil hanya bila `shareLocation` diisi.
final locationEnabledProvider = Provider<bool>(
  (ref) => ref.watch(locationMapConfigProvider) != null,
  name: 'locationEnabledProvider',
);

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
