import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension QRefExt2<T> on AutoDisposeNotifierProviderRef<T> {
  void subscribe<R>(
    AutoDisposeStreamProvider<R> provider,
    void Function(R) onData,
  ) {
    var sub = listen(provider, (_, AsyncValue<R> data) async {
      onData(await data.future);
    });
    onDispose(sub.close);
  }
}

extension QRefExt1 on AutoDisposeStateNotifierProviderRef {
  void subscribe<R>(
    AutoDisposeStreamProvider<R> provider,
    void Function(R) onData,
  ) async {
    var sub = listen(provider, (_, AsyncValue<R> data) async {
      onData(await data.future);
    });
    onDispose(() => sub.close());
  }

  void wait<R>(
    AutoDisposeFutureProvider<R> provider,
    void Function(R) onData,
  ) async {
    var data = await watch(provider.future);
    onData(data);
  }
}

extension AsyncValueExt<T> on AsyncValue<T> {
  Future<T> get future async {
    final completer = Completer<T>();
    maybeWhen(
      orElse: () {},
      error: (e, trace) => completer.completeError(e, trace),
      data: (data) => completer.complete(data),
    );

    return completer.future;
  }
}

extension ListExt<T> on List<T> {
  List<T> updateAt({
    required int index,
    required T value,
  }) {
    return [
      ...sublist(0, index),
      value,
      ...sublist(index + 1, length),
    ];
  }
}
