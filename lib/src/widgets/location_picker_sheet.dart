import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../models.dart';
import '../provider.dart';
import '../utils/debouncer.dart';
import 'location_map_layers.dart';

/// Fallback used for `name` / `address` when reverse geocoding fails.
const _fallbackLocationLabel = 'Location';

/// Map shown before the first GPS fix arrives (Indonesia overview).
const _initialCenter = LatLng(-2.5, 118.0);
const _initialZoom = 4.0;
const _fixZoom = 17.0;

const _gpsTimeout = Duration(seconds: 20);
const _geocodeTimeout = Duration(seconds: 8);

/// Opens the location picker as a ~90% height modal bottom sheet.
///
/// [context] must be below the `QMultichannelProvider` (its `ProviderScope`),
/// e.g. the context of the chat form. The sheet route itself is pushed on the
/// navigator, which can sit above that scope, so the container is captured
/// here and re-provided to the sheet.
Future<void> showQLocationPicker(BuildContext context) {
  final container = ProviderScope.containerOf(context, listen: false);
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    // Vertical drags must pan the map, not close the sheet.
    enableDrag: false,
    isDismissible: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    clipBehavior: Clip.antiAlias,
    builder: (_) => UncontrolledProviderScope(
      container: container,
      child: const FractionallySizedBox(
        heightFactor: 0.9,
        child: QLocationPickerSheet(),
      ),
    ),
  );
}

enum _GpsStatus {
  idle,
  loading,
  ready,
  serviceDisabled,
  denied,
  deniedForever,
  error,
}

class QLocationPickerSheet extends ConsumerStatefulWidget {
  const QLocationPickerSheet({super.key});

  @override
  ConsumerState<QLocationPickerSheet> createState() =>
      _QLocationPickerSheetState();
}

class _QLocationPickerSheetState extends ConsumerState<QLocationPickerSheet>
    with WidgetsBindingObserver {
  final MapController _mapController = MapController();
  final Debouncer _geocodeDebouncer = Debouncer(600);

  bool _mapReady = false;
  LatLng? _pendingMove;

  /// Point under the centre pin (= camera centre).
  LatLng _selected = _initialCenter;

  /// Last GPS fix, shown as a blue dot + accuracy circle.
  Position? _gps;

  /// Accuracy (m) of the selected point; null once the user pans the map.
  double? _selectedAccuracy;

  /// Whether the user has picked a point at all (GPS or manual pan).
  bool _hasSelection = false;

  _GpsStatus _gpsStatus = _GpsStatus.idle;

  // Reverse geocoding state.
  int _geocodeSeq = 0;
  bool _geocoding = false;
  LatLng? _resolvedFor;
  String? _placeName;
  String? _placeAddress;

  bool _sending = false;
  String? _sendError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Ask for permission and fetch the current position right away.
    WidgetsBinding.instance.addPostFrameCallback((_) => _useCurrentLocation());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _geocodeDebouncer.dispose();
    _mapController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Coming back from system settings: retry if we were blocked there.
    if (state == AppLifecycleState.resumed &&
        (_gpsStatus == _GpsStatus.serviceDisabled ||
            _gpsStatus == _GpsStatus.deniedForever)) {
      _useCurrentLocation();
    }
  }

  // ---------------------------------------------------------------- GPS

  Future<void> _useCurrentLocation() async {
    if (_gpsStatus == _GpsStatus.loading) return;
    setState(() => _gpsStatus = _GpsStatus.loading);

    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        _setGpsStatus(_GpsStatus.serviceDisabled);
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        _setGpsStatus(_GpsStatus.deniedForever);
        return;
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.unableToDetermine) {
        _setGpsStatus(_GpsStatus.denied);
        return;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: _gpsTimeout,
        ),
      );
      if (!mounted) return;

      final point = LatLng(position.latitude, position.longitude);
      setState(() {
        _gps = position;
        _gpsStatus = _GpsStatus.ready;
        _selected = point;
        _selectedAccuracy = position.accuracy;
        _hasSelection = true;
      });
      _moveMap(point);
      _scheduleGeocode(point, immediate: true);
    } on LocationServiceDisabledException {
      _setGpsStatus(_GpsStatus.serviceDisabled);
    } on PermissionDeniedException {
      _setGpsStatus(_GpsStatus.denied);
    } catch (_) {
      // TimeoutException, platform errors, ...
      _setGpsStatus(_GpsStatus.error);
    }
  }

  void _setGpsStatus(_GpsStatus status) {
    if (!mounted) return;
    setState(() => _gpsStatus = status);
  }

  void _moveMap(LatLng point) {
    if (!_mapReady) {
      _pendingMove = point;
      return;
    }
    _mapController.move(point, _fixZoom);
  }

  void _onMapReady() {
    _mapReady = true;
    final pending = _pendingMove;
    _pendingMove = null;
    if (pending != null) _mapController.move(pending, _fixZoom);
  }

  // flutter_map 7.x and 8.x share this callback signature.
  void _onPositionChanged(MapCamera camera, bool hasGesture) {
    // Programmatic moves (GPS fix, resize) keep the selection set by
    // _useCurrentLocation, including its accuracy.
    if (!hasGesture) return;
    final center = camera.center;
    setState(() {
      _selected = center;
      _selectedAccuracy = null; // picked manually
      _hasSelection = true;
      _sendError = null;
    });
    _scheduleGeocode(center);
  }

  // ---------------------------------------------------------- Geocoding

  void _scheduleGeocode(LatLng point, {bool immediate = false}) {
    if (immediate) {
      _geocodeDebouncer.dispose();
      _reverseGeocode(point);
    } else {
      if (!_geocoding) setState(() => _geocoding = true);
      _geocodeDebouncer.run(() => _reverseGeocode(point));
    }
  }

  Future<void> _reverseGeocode(LatLng point) async {
    final seq = ++_geocodeSeq;
    if (mounted) setState(() => _geocoding = true);

    final result = await _lookup(point);
    if (!mounted || seq != _geocodeSeq) return; // stale
    _applyGeocode(point, result);
  }

  void _applyGeocode(LatLng point, _Place? result) {
    setState(() {
      _geocoding = false;
      _resolvedFor = point;
      _placeName = result?.name;
      _placeAddress = result?.address;
    });
  }

  /// Returns the place or null when lookup fails / times out.
  static Future<_Place?> _lookup(LatLng point) async {
    try {
      final placemarks = await geocoding
          .placemarkFromCoordinates(point.latitude, point.longitude)
          .timeout(_geocodeTimeout);
      if (placemarks.isEmpty) return null;
      final p = placemarks.first;

      String? clean(String? v) {
        final t = v?.trim();
        return (t == null || t.isEmpty) ? null : t;
      }

      final parts = <String>[];
      for (final v in [
        clean(p.street) ?? clean(p.thoroughfare),
        clean(p.subLocality),
        clean(p.locality),
        clean(p.subAdministrativeArea),
        clean(p.administrativeArea),
        clean(p.postalCode),
        clean(p.country),
      ]) {
        if (v != null && !parts.contains(v)) parts.add(v);
      }

      final name = clean(p.name) ??
          clean(p.street) ??
          clean(p.locality) ??
          _fallbackLocationLabel;
      final address = parts.isEmpty ? _fallbackLocationLabel : parts.join(', ');
      return _Place(name, address);
    } catch (_) {
      return null;
    }
  }

  bool _sameAsResolved(LatLng point) {
    final r = _resolvedFor;
    return r != null &&
        (r.latitude - point.latitude).abs() < 1e-6 &&
        (r.longitude - point.longitude).abs() < 1e-6;
  }

  // --------------------------------------------------------------- Send

  Future<void> _send() async {
    if (_sending || !_hasSelection) return;
    final point = _selected;
    final accuracy = _selectedAccuracy;

    setState(() {
      _sending = true;
      _sendError = null;
    });

    String name;
    String address;
    if (_sameAsResolved(point)) {
      name = _placeName ?? _fallbackLocationLabel;
      address = _placeAddress ?? _fallbackLocationLabel;
    } else {
      // Geocoding for this exact point hasn't finished yet.
      _geocodeDebouncer.dispose();
      _geocodeSeq++;
      final result = await _lookup(point);
      if (!mounted) return;
      _applyGeocode(point, result);
      name = result?.name ?? _fallbackLocationLabel;
      address = result?.address ?? _fallbackLocationLabel;
    }

    try {
      final location = QLocation(
        latitude: point.latitude,
        longitude: point.longitude,
        name: name,
        address: address,
        accuracy: accuracy,
      );
      await ref.read(QMultichannel.provider).sendLocationMessage(location);
      if (!mounted) return;
      Navigator.of(context).pop();
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _sending = false;
        _sendError = 'Failed to send location. Please try again.';
      });
    }
  }

  // ----------------------------------------------------------------- UI

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeConfigProvider);
    final accent = theme.navigationColor;
    final onAccent = theme.navigationTitleColor;
    final gps = _gps;
    final gpsPoint = gps == null ? null : LatLng(gps.latitude, gps.longitude);
    final gpsBanner = _buildGpsBanner(accent);

    return Column(
      children: [
        _buildHeader(context),
        Expanded(
          child: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _initialCenter,
                  initialZoom: _initialZoom,
                  minZoom: 2,
                  maxZoom: 19,
                  onMapReady: _onMapReady,
                  onPositionChanged: _onPositionChanged,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                  ),
                ),
                children: [
                  const QLocationTileLayer(),
                  if (gps != null && gpsPoint != null) ...[
                    CircleLayer(
                      circles: [
                        CircleMarker(
                          point: gpsPoint,
                          radius: gps.accuracy,
                          useRadiusInMeter: true,
                          color: const Color(0x332196F3),
                          borderColor: const Color(0x992196F3),
                          borderStrokeWidth: 1,
                        ),
                      ],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: gpsPoint,
                          width: 18,
                          height: 18,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF2196F3),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: const [
                                BoxShadow(color: Colors.black26, blurRadius: 3),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              // Fixed centre pin: its tip marks the camera centre.
              IgnorePointer(
                child: Center(
                  child: Transform.translate(
                    offset: const Offset(0, -22),
                    child: Icon(Icons.location_on, size: 48, color: accent),
                  ),
                ),
              ),
              _buildAttribution(),
              Positioned(
                right: 12,
                bottom: 36,
                child: FloatingActionButton.small(
                  heroTag: null,
                  tooltip: 'Use current location',
                  backgroundColor: Colors.white,
                  onPressed: _gpsStatus == _GpsStatus.loading
                      ? null
                      : _useCurrentLocation,
                  child: _gpsStatus == _GpsStatus.loading
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: accent,
                          ),
                        )
                      : Icon(Icons.my_location, color: accent),
                ),
              ),
              if (gpsBanner != null)
                Positioned(left: 12, right: 12, top: 12, child: gpsBanner),
            ],
          ),
        ),
        _buildFooter(accent, onAccent),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Share location',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Close',
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildAttribution() {
    return const Positioned(
      left: 0,
      bottom: 0,
      child: QLocationMapAttribution(),
    );
  }

  /// Message + action for permission / service problems, or null.
  Widget? _buildGpsBanner(Color accent) {
    String message;
    String? actionLabel;
    VoidCallback? action;
    switch (_gpsStatus) {
      case _GpsStatus.serviceDisabled:
        message = 'Location services are turned off. '
            'Turn them on to use your current location.';
        actionLabel = 'Open settings';
        action = () => Geolocator.openLocationSettings();
        break;
      case _GpsStatus.denied:
        message = 'Location permission was denied. '
            'You can still move the map to pick a location.';
        actionLabel = 'Try again';
        action = _useCurrentLocation;
        break;
      case _GpsStatus.deniedForever:
        message = 'Location permission is permanently denied. '
            'Allow it in app settings, or move the map to pick a location.';
        actionLabel = 'Open settings';
        action = () => Geolocator.openAppSettings();
        break;
      case _GpsStatus.error:
        message = 'Could not get your current location. '
            'You can move the map to pick a location.';
        actionLabel = 'Try again';
        action = _useCurrentLocation;
        break;
      case _GpsStatus.idle:
      case _GpsStatus.loading:
      case _GpsStatus.ready:
        return null;
    }

    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
        child: Row(
          children: [
            const Icon(Icons.location_off, color: Colors.redAccent, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ),
            TextButton(
              onPressed: action,
              child: Text(actionLabel, style: TextStyle(color: accent)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccuracyRow() {
    final accuracy = _selectedAccuracy;
    final Color color;
    final IconData icon;
    final String label;

    if (_gpsStatus == _GpsStatus.loading && !_hasSelection) {
      color = Colors.black54;
      icon = Icons.gps_not_fixed;
      label = 'Getting your current location…';
    } else if (!_hasSelection) {
      color = Colors.black54;
      icon = Icons.pan_tool_alt_outlined;
      label = 'Move the map to pick a location';
    } else if (accuracy == null) {
      color = Colors.black54;
      icon = Icons.pan_tool_alt_outlined;
      label = 'Location picked manually on the map';
    } else {
      color = accuracy <= 20
          ? const Color(0xFF2E7D32) // green
          : accuracy <= 100
              ? const Color(0xFFF9A825) // yellow
              : const Color(0xFFC62828); // red
      icon = Icons.gps_fixed;
      label = 'GPS accuracy ±${accuracy.round()} m';
    }

    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooter(Color accent, Color onAccent) {
    final resolved = _hasSelection && _sameAsResolved(_selected);
    final String title;
    final String subtitle;
    if (!_hasSelection) {
      title = 'No location selected';
      subtitle = '';
    } else if (_geocoding || !resolved) {
      title = 'Finding address…';
      subtitle = _coords(_selected);
    } else {
      title = _placeName ?? _fallbackLocationLabel;
      subtitle = _placeAddress ?? _coords(_selected);
    }

    return Material(
      color: Colors.white,
      elevation: 8,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAccuracyRow(),
              const SizedBox(height: 8),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              if (subtitle.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ),
              if (_sendError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    _sendError!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFFC62828),
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: accent,
                        side: BorderSide(color: accent),
                        minimumSize: const Size.fromHeight(44),
                      ),
                      onPressed: _gpsStatus == _GpsStatus.loading || _sending
                          ? null
                          : _useCurrentLocation,
                      icon: const Icon(Icons.my_location, size: 18),
                      label: const Text('Use current location'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accent,
                        foregroundColor: onAccent,
                        minimumSize: const Size.fromHeight(44),
                      ),
                      onPressed: _hasSelection && !_sending ? _send : null,
                      icon: _sending
                          ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: onAccent,
                              ),
                            )
                          : const Icon(Icons.send, size: 18),
                      label: const Text('Send location'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _coords(LatLng p) =>
      '${p.latitude.toStringAsFixed(6)}, ${p.longitude.toStringAsFixed(6)}';
}

class _Place {
  const _Place(this.name, this.address);

  final String name;
  final String address;
}
