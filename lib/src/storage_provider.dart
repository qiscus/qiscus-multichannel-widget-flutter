import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
import 'package:qiscus_multichannel_widget/src/states/app_state.dart';

part 'storage_provider.freezed.dart';

@freezed
class QLocalUserData with _$QLocalUserData {
  const factory QLocalUserData({
    required String? appId,
    required int? roomId,
    required String? token,
    required QAccount? account,
  }) = _QLocalUserData;
}

final localUserDataProvider = StateNotifierProvider<QLocalUserDataStateNotifier,
    AsyncValue<QLocalUserData?>>((ref) {
  return QLocalUserDataStateNotifier(ref);
});

class QLocalUserDataStateNotifier
    extends StateNotifier<AsyncValue<QLocalUserData?>> {
  QLocalUserDataStateNotifier(
    this.ref, [
    AsyncValue<QLocalUserData?> state = const AsyncValue.loading(),
  ]) : super(state);

  final Ref ref;
  late FlutterSecureStorage enc = ref.watch(encSharedPreferenceProvider);
  bool _isFetching = false;

  static const _appId$ = 'last-app-id';
  static const _token$ = 'last-identity-token';
  static const _roomId$ = 'last-room-id';
  static const _account$ = 'last-account';

  Future<String?> get appId => enc.read(key: _appId$);
  set appId(Future<String?> v) =>
      v.then((v) => enc.write(key: _appId$, value: v));

  Future<QAccount?> get account => enc
      .read(key: _account$)
      .maybeThen((v) => jsonDecode(v) as Map<String, Object?>)
      .maybeThen((v) => accountFromJson(v));
  set account(Future<QAccount?> account) => account
      .maybeThen((v) => accountToJson(v))
      .maybeThen((v) => jsonEncode(v))
      .then((v) => enc.write(key: _account$, value: v));

  Future<String?> get token => enc.read(key: _token$);
  set token(Future<String?> token) =>
      token.then((v) => enc.write(key: _token$, value: v));

  Future<int?> get roomId =>
      enc.read(key: _roomId$).maybeThen((v) => int.parse(v));
  set roomId(Future<int?> roomId) => roomId
      .maybeThen((v) => v.toString())
      .then((v) => enc.write(key: _roomId$, value: v));

  Future<void> fetchData() async {
    if (_isFetching || state.hasValue && state.valueOrNull != null) return;

    _isFetching = true;

    var appId = await this.appId;
    var account = await this.account;
    var token = await this.token;
    var roomId = await this.roomId;
    print(
        'fetching data! appId($appId) account($account) token($token) roomId($roomId)');

    var currentAppId = ref.read(appIdProvider);
    if (appId == currentAppId &&
        appId != null &&
        account != null &&
        token != null &&
        roomId != null) {
      ref.read(appStateProvider.notifier).state =
          AppState.loading(appId: appId);

      ref.read(userIdProvider.notifier).state = account.id;
      var qiscus = await ref.read(qiscusProvider.future);
      qiscus.storage.currentUser = account;
      qiscus.storage.token = token;

      var data = await qiscus.getChatRoomWithMessages(roomId: roomId);

      var isSessional = await ref.read(sessionalProvider.future);
      var isResolved = data.room.extras?['is_resolved'] as bool?;
      ref.read(isResolvedProvider.notifier).state = isResolved ?? false;
      ref.read(isSessionalProvider.notifier).state = isSessional;

      print('[storage] isSessional($isSessional) isResolved($isResolved)');

      if (isSessional == false || isResolved == false) {
        ref.read(appStateProvider.notifier).state =
            AppState.ready(roomId: roomId, account: account);

        state = AsyncValue.data(QLocalUserData(
          appId: appId,
          token: token,
          roomId: data.room.id,
          account: account,
        ));
      }
    } else {
      state = const AsyncValue.data(null);
    }

    _isFetching = false;
  }

  void setData(QLocalUserData data) async {
    state = state.copyWithPrevious(AsyncValue.data(data));

    appId = Future.value(data.appId);
    account = Future.value(data.account);
    token = Future.value(data.token);
    roomId = Future.value(data.roomId);
  }

  Future<void> clear() async {
    await enc.deleteAll();
  }
}

Map<String, Object?> accountToJson(QAccount account) {
  return <String, Object?>{
    'email': account.id,
    'username': account.name,
    'avatar_url': account.avatarUrl,
    'last_comment_id': account.lastMessageId,
    'last_sync_event_id': account.lastEventId,
    'extras': account.extras,
  };
}

QAccount accountFromJson(Map<String, Object?> json) {
  Map<String, Object?>? extras;
  if (json['extras'] != null) {
    extras = decodeJson(json['extras']);
  }

  return QAccount(
    id: json['email'] as String,
    name: json['username'] as String,
    avatarUrl: json['avatar_url'] as String,
    lastMessageId: (json['last_comment_id'] as int),
    lastEventId: (json['last_sync_event_id'] as int),
    extras: extras,
  );
}

Map<String, Object?>? decodeJson(Object? json) {
  if (json is Map && json.isNotEmpty) {
    return json as Map<String, Object?>;
  }
  if (json is String && json.isNotEmpty) {
    return jsonDecode(json) as Map<String, Object?>;
  }

  return null;
}

extension FutureExt<T> on Future<T?> {
  Future<Out?> maybeThen<Out>(FutureOr<Out> Function(T) cb) {
    return then((v) => v == null ? null : cb(v));
  }
}
