import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: implementation_imports
import 'package:qiscus_multichannel_widget/src/utils/extensions.dart';

/// Stream provider yang dikontrol test: eventnya bisa disuntik langsung,
/// termasuk error, tanpa menyentuh SDK.
final testStreamProvider = StreamProvider.autoDispose<int>((ref) {
  throw UnimplementedError();
});

/// Notifier yang memakai `ref.subscribe`, meniru MessagesNotifier.
class _Subscriber extends AutoDisposeNotifier<int> {
  /// Nilai terakhir yang diterima onData, supaya test bisa memastikan
  /// callback benar-benar dipanggil (bukan hanya state tidak berubah).
  final received = <int>[];

  @override
  int build() {
    ref.subscribe(testStreamProvider, (int value) {
      received.add(value);
      state = value;
    });
    return 0;
  }
}

final subscriberProvider =
    NotifierProvider.autoDispose<_Subscriber, int>(_Subscriber.new);

void main() {
  late StreamController<int> controller;
  late ProviderContainer container;
  late _Subscriber notifier;

  setUp(() async {
    controller = StreamController<int>();
    container = ProviderContainer(
      overrides: [
        testStreamProvider.overrideWith((ref) {
          ref.onDispose(controller.close);
          return controller.stream;
        }),
      ],
    );
    addTearDown(container.dispose);

    // Bangun notifier dan tunggu sampai stream provider selesai attach.
    notifier = container.read(subscriberProvider.notifier);
    container.listen(subscriberProvider, (_, __) {});
    await settle();
  });

  test('data event diteruskan ke onData', () async {
    controller.add(42);
    await settle();

    expect(notifier.received, [42]);
    expect(container.read(subscriberProvider), 42);
  });

  test('AsyncError tidak menjadi unhandled error dan state tetap utuh',
      () async {
    controller.addError(StateError('mqtt socket drop'));
    await settle();

    // Error dilempar dari callback async yang future-nya dibuang akan
    // menggagalkan test sebagai unhandled zone error. State harus utuh.
    expect(notifier.received, isEmpty);
    expect(container.read(subscriberProvider), 0);
  });

  test('event setelah error tetap diteruskan', () async {
    controller.addError(StateError('mqtt socket drop'));
    controller.add(7);
    await settle();

    expect(notifier.received, [7]);
    expect(container.read(subscriberProvider), 7);
  });

  // Catatan: sinkronisasi onData versus await Future tidak bisa dibuktikan dari
  // sini — stream event-nya sendiri sudah datang lewat microtask. Yang diuji
  // adalah error path dan urutan event, dua hal yang rusak di implementasi lama.
}

/// Biarkan async* provider dan listener stream selesai jalan.
Future<void> settle() async {
  for (var i = 0; i < 10; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}
