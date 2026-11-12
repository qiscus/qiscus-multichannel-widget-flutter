import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models.dart';
import '../provider.dart';
import 'location_map_layers.dart';

/// Bubble pesan lokasi: thumbnail peta non-interaktif (OSM atau Google,
/// sesuai `shareLocation`) + nama/alamat.
/// Tap membuka `map_url` (Google Maps) di aplikasi eksternal.
class QChatLocation extends ConsumerWidget {
  const QChatLocation({
    super.key,
    required this.message,
  });

  final QMessageLocation message;

  static const double mapHeight = 140;
  static const double maxWidth = 240;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var width = math.min(maxWidth, size.width * 0.6);
    final bgColor = ref.watch(chatBubbleBgColorProvider(message.sender));
    final fgColor = ref.watch(chatBubbleFgColorProvider(message.sender));
    var location = message.location;
    var failed = message.status.name == 'failed';
    var showAddress = location.address != location.name;

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 5),
      child: Semantics(
        button: true,
        label: 'Location: ${location.name}. Open in maps',
        excludeSemantics: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _openMap(location),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: width,
              color: bgColor,
              padding: const EdgeInsets.all(3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: SizedBox(
                      height: mapHeight,
                      width: double.infinity,
                      child: _LocationMapThumbnail(location: location),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(7, 7, 7, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          location.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: fgColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (showAddress)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              location.address,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: fgColor.withAlpha(204),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        if (failed)
                          // Row non-const: `const Row` belum ada di Flutter
                          // lama (flutter_map 7 masih mendukung Flutter 3.10).
                          // ignore: prefer_const_constructors
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            // ignore: prefer_const_constructors
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.error_outline,
                                    size: 14, color: Colors.red),
                                SizedBox(width: 4),
                                Text(
                                  'Failed to send',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openMap(QLocation location) async {
    // Selalu pakai URL yang dihitung dari koordinat, bukan `map_url` mentah
    // dari payload (bisa berisi URL arbitrer dari channel/pengirim lain).
    var uri = Uri.parse(location.mapUrl);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('[QMultichannel] failed to open map: $e');
    }
  }
}

class _LocationMapThumbnail extends StatelessWidget {
  const _LocationMapThumbnail({required this.location});

  final QLocation location;

  @override
  Widget build(BuildContext context) {
    var point = LatLng(location.latitude, location.longitude);

    // IgnorePointer: peta hanya thumbnail; tap ditangani bubble.
    return IgnorePointer(
      child: Stack(
        children: [
          FlutterMap(
            // initialCenter hanya dipakai saat dibuat: key per titik agar
            // item list yang di-recycle tidak menampilkan peta lama.
            key: ValueKey('${location.latitude},${location.longitude}'),
            options: MapOptions(
              initialCenter: point,
              initialZoom: 15,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.none,
              ),
            ),
            children: [
              const QLocationTileLayer(),
              MarkerLayer(
                markers: [
                  Marker(
                    point: point,
                    width: 36,
                    height: 36,
                    alignment: Alignment.topCenter,
                    child: const Icon(
                      Icons.location_on,
                      size: 36,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: QLocationMapAttribution(compact: true),
          ),
        ],
      ),
    );
  }
}
