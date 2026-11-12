import 'package:qiscus_chat_sdk/qiscus_chat_sdk.dart' hide QAccount;

class QMessageText extends QMessage {
  QMessageText({
    required super.id,
    required super.chatRoomId,
    required super.previousMessageId,
    required super.uniqueId,
    required super.text,
    required super.status,
    required super.type,
    required Map<String, dynamic>? super.extras,
    required Map<String, dynamic>? super.payload,
    required super.sender,
    required super.timestamp,
  });
}

class QMessageReply extends QMessage {
  QMessageReply.fromMessage(QMessage message)
      : super(
          id: message.id,
          chatRoomId: message.chatRoomId,
          previousMessageId: message.previousMessageId,
          uniqueId: message.uniqueId,
          text: message.text,
          status: message.status,
          type: message.type,
          extras: message.extras,
          payload: message.payload,
          sender: message.sender,
          timestamp: message.timestamp,
        );

  static QMessageReply? tryParse(QMessage message) {
    if (message.type == QMessageType.reply) {
      return QMessageReply.fromMessage(message);
    }
    return null;
  }

  QMessageReplyPayload get typedPayload {
    return QMessageReplyPayload(payload!);
  }
}

class QMessageReplyPayload {
  QMessageReplyPayload(Map<String, Object?> payload)
      : repliedCommentId = payload['replied_comment_id'] as int,
        repliedCommentIsDeleted = payload['replied_comment_is_deleted'] as bool,
        repliedCommentPayload =
            payload['replied_comment_payload'] as Map<String, Object?>?,
        repliedCommentSenderEmail =
            payload['replied_comment_sender_email'] as String,
        repliedCommentSenderUsername =
            payload['replied_comment_sender_username'] as String,
        repliedCommentType = payload['replied_comment_type'] as String,
        repliedCommentMessage = payload['replied_comment_message'] as String,
        message = payload['text'] as String;

  final int repliedCommentId;
  final bool repliedCommentIsDeleted;
  final String repliedCommentMessage;
  final Map<String, Object?>? repliedCommentPayload;
  final String repliedCommentSenderEmail;
  final String repliedCommentSenderUsername;
  final String repliedCommentType;
  final String message;
  // 0 = {map entry} "replied_comment_id" -> 2028902450
  // 1 = {map entry} "replied_comment_is_deleted" -> false
  // 2 = {map entry} "replied_comment_message" -> "lagi?"
  // 3 = {map entry} "replied_comment_payload" -> [_Map]
  // 4 = {map entry} "replied_comment_sender_email" -> "guest-1001"
  // 5 = {map entry} "replied_comment_sender_username" -> "guest-1001"
  // 6 = {map entry} "replied_comment_type" -> "text"
  // 7 = {map entry} "text" -> "ada yang bisa dibantu?"
}

class QMessageImage extends QMessage {
  static final fileRe = RegExp(r'(https?:\/\/.*\.(?:png|jpg|jpeg|gif))');
  late String url = fileRe.stringMatch(text)!;

  QMessageImage.fromMessage(QMessage message)
      : super(
          id: message.id,
          chatRoomId: message.chatRoomId,
          previousMessageId: message.previousMessageId,
          uniqueId: message.uniqueId,
          text: message.text,
          status: message.status,
          type: message.type,
          extras: message.extras,
          payload: message.payload,
          sender: message.sender,
          timestamp: message.timestamp,
        );

  static QMessageImage? tryParse(QMessage message) {
    var url = fileRe.stringMatch(message.text);
    if (message.type == QMessageType.attachment && url != null) {
      return QMessageImage.fromMessage(message);
    }

    return null;
  }
}

class QMessageVideo extends QMessage {
  static final fileRe = RegExp(r'(https?:\/\/.*\.(?:mp4|ogg|mkv|3gp|aac))');
  late final url = fileRe.stringMatch(text)!;

  QMessageVideo.fromMessage(QMessage message)
      : super(
          id: message.id,
          chatRoomId: message.chatRoomId,
          previousMessageId: message.previousMessageId,
          uniqueId: message.uniqueId,
          text: message.text,
          status: message.status,
          type: message.type,
          extras: message.extras,
          payload: message.payload,
          sender: message.sender,
          timestamp: message.timestamp,
        );

  static QMessageVideo? tryParse(QMessage message) {
    var url = fileRe.stringMatch(message.text);

    if (url != null) {
      message.type = QMessageType.attachment;
    }
    if (message.type == QMessageType.attachment && url != null) {
      return QMessageVideo.fromMessage(message);
    }

    return null;
  }
}

class QMessageFile extends QMessage {
  late final url = text //
      .replaceAll('[file]', '')
      .replaceAll('[/file]', '')
      .trim();

  QMessageFile.fromMessage(QMessage message)
      : super(
          id: message.id,
          chatRoomId: message.chatRoomId,
          previousMessageId: message.previousMessageId,
          uniqueId: message.uniqueId,
          text: message.text,
          status: message.status,
          type: message.type,
          extras: message.extras,
          payload: message.payload,
          sender: message.sender,
          timestamp: message.timestamp,
        );

  static QMessageFile? tryParse(QMessage message) {
    String? url;

    var containsFileTag =
        message.text.contains('[file]') && message.text.contains('[/file]');
    var isImage = QMessageImage.fileRe.hasMatch(message.text);
    var isVideo = QMessageVideo.fileRe.hasMatch(message.text);
    if (containsFileTag && !(isImage || isVideo)) {
      url = message.text
          .replaceAll('[file]', '')
          .replaceAll('[/file]', '')
          .trim();
    }

    if (url != null) {
      message.type = QMessageType.attachment;
    }
    if (message.type == QMessageType.attachment && url != null) {
      return QMessageFile.fromMessage(message);
    }

    return null;
  }
}

/// Titik lokasi yang dibagikan lewat pesan `type: "location"`.
///
/// Format payload mengikuti pesan lokasi baku Qiscus/Omnichannel (sama dengan
/// lokasi WhatsApp yang dibuat qismo-api dan sudah dirender dashboard):
/// `{latitude, longitude, name, address, map_url}` + `accuracy` (meter; null
/// bila titik dipilih manual).
class QLocation {
  /// Teks comment untuk pesan lokasi (sama dengan qismo-api).
  static const messageText = 'Sent Location';

  /// Nilai `type` comment di server dan `payload['type']` di widget.
  static const messageType = 'location';

  /// Fallback name/address bila kosong (sama dengan qismo-api).
  static const fallbackLabel = 'Location';

  /// Membuat lokasi; latitude/longitude dibulatkan 6 desimal.
  ///
  /// Melempar [ArgumentError] bila latitude/longitude tidak finite atau
  /// latitude di luar -90..90. Longitude di luar -180..180 di-wrap.
  QLocation({
    required double latitude,
    required double longitude,
    String? name,
    String? address,
    double? accuracy,
  })  : latitude = _round6(_checkLatitude(latitude)),
        longitude = _round6(_wrapLongitude(longitude)),
        name = _labelOrFallback(name),
        address = _labelOrFallback(address),
        accuracy = (accuracy != null && accuracy.isFinite && accuracy >= 0)
            ? accuracy
            : null;

  final double latitude, longitude;
  final String name, address;

  /// Akurasi GPS dalam meter; null bila titik dipilih manual.
  final double? accuracy;

  String get mapUrl => 'https://maps.google.com/?q=$latitude,$longitude';

  /// Payload yang dikirim ke server (tanpa key `type`).
  Map<String, dynamic> toPayload() => <String, dynamic>{
        'latitude': latitude,
        'longitude': longitude,
        'name': name,
        'address': address,
        'map_url': mapUrl,
        'accuracy': accuracy,
      };

  /// Payload pesan lokal (optimistic): sama seperti hasil parse SDK untuk
  /// pesan masuk ber-type `location` (payload server + `type`).
  Map<String, dynamic> toMessagePayload() => <String, dynamic>{
        ...toPayload(),
        'type': messageType,
      };

  /// Body `POST /api/v2/mobile/post_comment`.
  Map<String, dynamic> toPostCommentBody({
    required int roomId,
    required String uniqueId,
  }) =>
      <String, dynamic>{
        'topic_id': roomId.toString(),
        'comment': messageText,
        'type': messageType,
        'unique_temp_id': uniqueId,
        'payload': toPayload(),
        'extras': <String, dynamic>{},
      };

  /// Parse payload pesan lokasi secara toleran.
  ///
  /// - latitude/longitude boleh num atau String (data dari channel lain);
  ///   alias `lat`/`lng` juga diterima.
  /// - Field boleh berada di root payload, atau di `content` / `payload`
  ///   (bentuk custom message SDK `{type, content}`).
  /// - Mengembalikan null bila koordinat tidak ada/tidak valid.
  static QLocation? fromPayload(Map? payload) {
    if (payload == null) return null;

    for (var candidate in [payload, payload['content'], payload['payload']]) {
      if (candidate is! Map) continue;
      var lat = _toDouble(candidate['latitude'] ?? candidate['lat']);
      var lng = _toDouble(candidate['longitude'] ?? candidate['lng']);
      if (lat == null || lng == null) continue;
      if (lat.abs() > 90 || lng.abs() > 180) return null;

      return QLocation(
        latitude: lat,
        longitude: lng,
        name: _toLabel(candidate['name']),
        address: _toLabel(candidate['address']),
        accuracy: _toDouble(candidate['accuracy']),
      );
    }
    return null;
  }

  @override
  String toString() => 'QLocation($latitude, $longitude, name=$name, '
      'address=$address, accuracy=$accuracy)';

  static double _round6(double value) {
    var rounded = double.parse(value.toStringAsFixed(6));
    // Hindari "-0.0" di map_url.
    return rounded == 0 ? 0.0 : rounded;
  }

  static double _checkLatitude(double value) {
    if (!value.isFinite || value.abs() > 90) {
      throw ArgumentError.value(value, 'latitude', 'must be within -90..90');
    }
    return value;
  }

  static double _wrapLongitude(double value) {
    if (!value.isFinite) {
      throw ArgumentError.value(value, 'longitude', 'must be finite');
    }
    if (value >= -180 && value <= 180) return value;
    return ((value + 180) % 360 + 360) % 360 - 180;
  }

  static String _labelOrFallback(String? value) {
    var trimmed = value?.trim();
    return (trimmed == null || trimmed.isEmpty) ? fallbackLabel : trimmed;
  }

  static String? _toLabel(Object? value) {
    if (value is String) return value;
    if (value is num) return value.toString();
    return null;
  }

  static double? _toDouble(Object? value) {
    double? result;
    if (value is num) result = value.toDouble();
    if (value is String) result = double.tryParse(value.trim());
    return (result != null && result.isFinite) ? result : null;
  }
}

class QMessageLocation extends QMessage {
  QMessageLocation.fromMessage(QMessage message, this.location)
      : super(
          id: message.id,
          chatRoomId: message.chatRoomId,
          previousMessageId: message.previousMessageId,
          uniqueId: message.uniqueId,
          text: message.text,
          status: message.status,
          type: message.type,
          extras: message.extras,
          payload: message.payload,
          sender: message.sender,
          timestamp: message.timestamp,
        );

  final QLocation location;

  /// Pesan lokasi = `QMessageType.custom` dengan `payload['type'] ==
  /// 'location'` (SDK menambahkan `type` untuk comment ber-type `location`).
  /// Null bila bukan pesan lokasi atau koordinatnya tidak valid, sehingga
  /// pesan jatuh ke render teks biasa.
  static QMessageLocation? tryParse(QMessage message) {
    if (message.type != QMessageType.custom) return null;
    var payload = message.payload;
    if (payload == null || payload['type'] != QLocation.messageType) {
      return null;
    }

    var location = QLocation.fromPayload(payload);
    if (location == null) return null;
    return QMessageLocation.fromMessage(message, location);
  }
}

class QMessageSystem extends QMessage {
  QMessageSystem.fromMessage(QMessage message)
      : super(
          id: message.id,
          chatRoomId: message.chatRoomId,
          previousMessageId: message.previousMessageId,
          uniqueId: message.uniqueId,
          text: message.text,
          status: message.status,
          type: message.type,
          extras: message.extras,
          payload: message.payload,
          sender: message.sender,
          timestamp: message.timestamp,
        );

  static QMessageSystem? tryParse(QMessage message) {
    var type = message.type;
    var senderName = message.sender.name.isNotEmpty
        ? message.sender.name
        : message.payload?['object_username'] as String;

    if (type == QMessageType.custom && senderName.toLowerCase() == 'system') {
      return QMessageSystem.fromMessage(message);
    }
    return null;
  }
}
