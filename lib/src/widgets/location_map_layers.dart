import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/location_map_config.dart';
import '../provider.dart';

/// OpenStreetMap standard tile server. Heavy usage must follow
/// https://operations.osmfoundation.org/policies/tiles/ (see README).
const qOsmTileUrl = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
const _osmCopyrightUrl = 'https://www.openstreetmap.org/copyright';
const qMapUserAgentPackageName = 'com.qiscus.multichannel_widget';

/// Google Map Tiles API 2D tiles; `{session}` / `{key}` diisi saat build.
const _googleTileUrl =
    'https://tile.googleapis.com/v1/2dtiles/{z}/{x}/{y}?session={session}&key={key}';
const _googleTermsUrl = 'https://www.google.com/intl/en_US/help/terms_maps/';

/// Tile layer sesuai `locationMapConfigProvider`: OpenStreetMap (default)
/// atau Google Map Tiles API dengan key milik client.
class QLocationTileLayer extends ConsumerWidget {
  const QLocationTileLayer({super.key, this.maxZoom = 19});

  final double maxZoom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var config = ref.watch(locationMapConfigProvider) ??
        const QLocationMapConfig.openStreetMap();
    if (!config.isGoogle) {
      return TileLayer(
        urlTemplate: qOsmTileUrl,
        userAgentPackageName: qMapUserAgentPackageName,
        maxZoom: maxZoom,
      );
    }

    var session = ref.watch(googleTileSessionProvider(config));
    return session.when(
      data: (s) {
        if (s.isExpired) {
          // Session Google berlaku ~2 minggu; minta yang baru.
          Future.microtask(
            () => ref.invalidate(googleTileSessionProvider(config)),
          );
        }
        return TileLayer(
          urlTemplate: _googleTileUrl,
          additionalOptions: {
            'session': s.session,
            'key': config.googleApiKey ?? '',
          },
          userAgentPackageName: qMapUserAgentPackageName,
          tileProvider: NetworkTileProvider(headers: config.googleHeaders),
          maxZoom: maxZoom,
        );
      },
      // Tanpa session tile Google tidak bisa dimuat; peta tetap bisa digeser
      // (pin & koordinat tetap bekerja), hanya latarnya kosong.
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}

/// Atribusi wajib sesuai sumber tile. [compact] untuk thumbnail bubble.
class QLocationMapAttribution extends ConsumerWidget {
  const QLocationMapAttribution({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isGoogle =
        ref.watch(locationMapConfigProvider)?.source == QMapTileSource.google;
    var text = isGoogle
        ? 'Google · Map data ©${DateTime.now().year} Google'
        : (compact ? '© OpenStreetMap' : '© OpenStreetMap contributors');
    var url = isGoogle ? _googleTermsUrl : _osmCopyrightUrl;

    var label = Container(
      color: const Color(0xCCFFFFFF),
      padding: compact
          ? const EdgeInsets.symmetric(horizontal: 3, vertical: 1)
          : const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Text(
        text,
        style: TextStyle(fontSize: compact ? 8 : 11, color: Colors.black87),
      ),
    );

    if (compact) return label;
    return GestureDetector(
      onTap: () => launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      ),
      child: label,
    );
  }
}
