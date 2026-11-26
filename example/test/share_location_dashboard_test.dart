import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';
import 'package:qiscus_multichannel_widget/src/config/share_location_dashboard_config.dart';

/// Share location dari dashboard: parsing respons, fallback, dan provider.
/// Key Google di sini dummy.
String _body({
  bool enabled = true,
  String provider = 'osm',
  String? key,
}) =>
    '{"data":{"enabled":$enabled,"provider":"$provider",'
    '"google_api_key":${key == null ? 'null' : '"$key"'}},"status":200}';

var _seq = 0;

/// Membaca provider efektif dengan HTTP palsu. Setiap panggilan memakai
/// baseUrl unik karena cache bersifat statis per (baseUrl, appId).
Future<(QLocationMapConfig?, List<Uri>)> _resolve(
  QLocationMapConfig? requested,
  http.Response Function(http.Request) handler, {
  String appId = 'app-1',
}) async {
  var calls = <Uri>[];
  var base = 'https://qismo-${_seq++}.example.test';
  var container = ProviderContainer(overrides: [
    baseUrlProvider.overrideWith((_) => base),
    appIdProvider.overrideWith((_) => appId),
    locationMapConfigProvider.overrideWith((_) => requested),
  ]);
  addTearDown(container.dispose);

  return http.runWithClient(() async {
    await container.read(shareLocationDashboardConfigProvider.future);
    return (container.read(effectiveLocationMapConfigProvider), calls);
  },
      () => MockClient((req) async {
            calls.add(req.url);
            return handler(req);
          }));
}

void main() {
  group('ShareLocationDashboardConfig.parse', () {
    test('osm aktif', () {
      var c = ShareLocationDashboardConfig.parse(_body())!;
      expect(c.usable, isTrue);
      expect(c.isGoogle, isFalse);
    });

    test('google dengan key', () {
      var c = ShareLocationDashboardConfig.parse(
          _body(provider: 'google', key: 'dummy-key'))!;
      expect(c.usable, isTrue);
      expect(c.isGoogle, isTrue);
      expect(c.googleApiKey, 'dummy-key');
    });

    test('google tanpa key tidak usable', () {
      var c = ShareLocationDashboardConfig.parse(_body(provider: 'google'))!;
      expect(c.usable, isFalse);
    });

    test('disabled tidak usable', () {
      var c = ShareLocationDashboardConfig.parse(_body(enabled: false))!;
      expect(c.usable, isFalse);
    });

    test('body rusak atau bentuk salah menghasilkan null', () {
      expect(ShareLocationDashboardConfig.parse('bukan json'), isNull);
      expect(ShareLocationDashboardConfig.parse('[]'), isNull);
      expect(ShareLocationDashboardConfig.parse('{"data":null}'), isNull);
      expect(ShareLocationDashboardConfig.parse('{"data":{}}'), isNull);
    });

    test('toString tidak membocorkan key', () {
      var c = ShareLocationDashboardConfig.parse(
          _body(provider: 'google', key: 'dummy-key'))!;
      expect(c.toString(), isNot(contains('dummy-key')));
    });
  });

  group('effectiveLocationMapConfigProvider', () {
    test('mode lama dipakai apa adanya tanpa request', () async {
      var (cfg, calls) = await _resolve(
        const QLocationMapConfig.openStreetMap(),
        (_) => http.Response('', 500),
      );
      expect(cfg?.source, QMapTileSource.openStreetMap);
      expect(calls, isEmpty);

      (cfg, calls) = await _resolve(
        const QLocationMapConfig.google(apiKey: 'dummy-key'),
        (_) => http.Response('', 500),
      );
      expect(cfg?.source, QMapTileSource.google);
      expect(cfg?.googleApiKey, 'dummy-key');
      expect(calls, isEmpty);
    });

    test('tanpa shareLocation menu tidak muncul', () async {
      var (cfg, calls) = await _resolve(null, (_) => http.Response('', 500));
      expect(cfg, isNull);
      expect(calls, isEmpty);
    });

    test('dashboard memilih OSM', () async {
      var (cfg, calls) = await _resolve(
        const QLocationMapConfig.dashboard(),
        (_) => http.Response(_body(), 200),
        appId: 'abc',
      );
      expect(cfg?.source, QMapTileSource.openStreetMap);
      expect(cfg?.googleApiKey, isNull);
      expect(calls.single.path, '/api/v2/share_location_config/abc');
    });

    test('dashboard memilih Google memakai key dari config', () async {
      var (cfg, _) = await _resolve(
        const QLocationMapConfig.dashboard(language: 'id-ID', region: 'ID'),
        (_) => http.Response(_body(provider: 'google', key: 'dummy-key'), 200),
      );
      expect(cfg?.source, QMapTileSource.google);
      expect(cfg?.googleApiKey, 'dummy-key');
      expect(cfg?.googleLanguage, 'id-ID');
    });

    test('disabled menyembunyikan menu', () async {
      var (cfg, _) = await _resolve(
        const QLocationMapConfig.dashboard(),
        (_) => http.Response(_body(enabled: false), 200),
      );
      expect(cfg, isNull);
    });

    test('404, 500, dan body rusak menyembunyikan menu', () async {
      for (var res in [
        http.Response('{"status":404}', 404),
        http.Response('', 500),
        http.Response('<html>', 200),
      ]) {
        var (cfg, _) = await _resolve(
          const QLocationMapConfig.dashboard(),
          (_) => res,
        );
        expect(cfg, isNull, reason: 'status ${res.statusCode}');
      }
    });

    test('request yang melempar error menyembunyikan menu', () async {
      var (cfg, _) = await _resolve(
        const QLocationMapConfig.dashboard(),
        (_) => throw http.ClientException('offline'),
      );
      expect(cfg, isNull);
    });
  });
}
