import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

extension QRefExt1 on AutoDisposeStateNotifierProviderRef {
  void subscribe<R>(
    AutoDisposeStreamProvider<R> provider,
    void Function(R) onData,
  ) {
    var subs = watch(provider.stream).listen(onData);
    onDispose(() {
      var name = provider.name;
      print('[autoDisposeRef] {$name}.dipose');
      subs.cancel();
    });
  }
}

extension QRefExt on Ref {
  void subscribe<R>(StreamProvider<R> provider, void Function(R) onData) {
    var subs = watch(provider.stream).listen(onData);
    onDispose(() {
      var name = provider.name;
      print('[ref] {$name}.dispose');
      subs.cancel();
    });
  }

  void wait<R>(FutureProvider<R> provider, void Function(R) onData) async {
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
