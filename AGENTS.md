# AGENTS.md — qiscus_multichannel_widget (Flutter)

Notes for coding agents working in this repo. Read this file in full before
changing code; user-facing docs live in `README.md`.

## Project

- Flutter package `qiscus_multichannel_widget`: the in-app Live Chat widget for
  Qiscus Omnichannel. State is Riverpod; the chat transport is `qiscus_chat_sdk`.
- `example/` is the sample app (iOS/Android) that depends on the package by
  path. Its `lib/constant.dart` holds a test appId/channelId; never commit a
  temporary tenant there.
- Minimum Dart SDK is 2.17 (`pubspec.yaml`): do not use Dart 3-only syntax
  (switch expressions, records, patterns, `const Row` from newer Flutter).

## Commands

- Analyze: `flutter analyze lib`. The deprecation infos already on `main` are
  the baseline; new code must add no errors, warnings or infos.
- Format: `dart format <files>`.
- Build check: `cd example && flutter build ios --no-codesign --debug`
  (Android: `flutter build apk --debug` when an Android SDK is installed).
- `flutter_test` is commented out in the package `pubspec.yaml`; do not enable
  it just to run a test. Test pure logic by copying it into a scratch Dart
  project and running it with `dart run`.
- Avoid `build_runner`: add plain `StateProvider`/`FutureProvider` in a `part`
  file registered in `lib/src/providers/provider.dart`.

## Features to know

### Share location (supported)

Customers can share a location: attachment menu → **Location** → bottom-sheet
map picker (replaces the attachment sheet) with **Use current location**, GPS
accuracy indicator, reverse-geocoded address and **Send location**.

It is controlled by ONE parameter, `QMultichannelProvider(shareLocation: ...)`:
`null` (default) = off; a `QLocationMapConfig` = on, with that map provider
(or, for `dashboard()`, on/off + provider from the dashboard).
Do not add a separate enable flag. The host app must declare the location
permissions (see README → Share Location).

The map supports **three options** (the value of `shareLocation`):

1. **OpenStreetMap — free** (`QLocationMapConfig.openStreetMap()`).
   Public tile server, no key, subject to the OSM tile usage policy.
2. **Google Maps — client's own key** (`QLocationMapConfig.google(apiKey: ...)`).
   Uses the Google Map Tiles API. Qiscus never ships or provides a Google key:
   the client creates it in their own Google Cloud project (billing + Map Tiles
   API enabled) and pays for the usage.
3. **From the dashboard** (`QLocationMapConfig.dashboard()`). Per-app setting
   saved in the Omnichannel dashboard (shared with the web widget), read from
   the public endpoint `GET {baseUrl}/api/v2/share_location_config/{appId}` →
   `{"data": {"enabled", "provider": "osm"|"google", "google_api_key"}}`.
   Menu shown only when `enabled` (and Google has a key); fetch failure,
   non-200, bad body or disabled = menu hidden. `osm` → option 1, `google` →
   option 2 with the dashboard key (the `dashboard()` mapType/language/region/
   headers are kept). Cached in memory per (baseUrl, appId) in
   `_ShareLocationConfigCache` (concurrent requests merged; a failed refresh
   keeps the last good value) and marked stale + re-read on every
   `initiateChat` (`refreshShareLocationDashboardConfig`). Addresses still come
   from the OS geocoder. Key restriction (documented in README → Option 3):
   Google allows ONE application restriction type per key; the web widget runs
   in a Qiscus iframe (Referer = widget domain, default
   `https://multichannel.qiscus.com/*`), while this widget calls Google with no
   Referer. A client using both either uses a Websites-restricted key (Flutter
   is then rejected) or no application restriction + API restriction (Map Tiles
   + Geocoding) + quota/budget alert; or passes a separate mobile key via
   `QLocationMapConfig.google(apiKey: ...)`.

Code map:

- `lib/src/config/location_map_config.dart` — `QLocationMapConfig`,
  `QMapTileSource`. `dashboard()` sets `fromDashboard = true` (its `source` is a
  placeholder); `resolveDashboard()` builds the effective config.
- `lib/src/config/share_location_dashboard_config.dart` — pure-Dart parse of the
  dashboard endpoint (`ShareLocationDashboardConfig`, internal); copy it into a
  scratch project to test.
- `lib/src/providers/location_provider.dart` — `locationMapConfigProvider`
  (`QLocationMapConfig?`, the requested value of `shareLocation`),
  `shareLocationDashboardConfigProvider` (dashboard fetch, dashboard mode only),
  `effectiveLocationMapConfigProvider` (the config UI code must read),
  `locationEnabledProvider` (derived: effective config != null), `googleTileSessionProvider` (Map Tiles API
  session), REST `post_comment` sender.
- `lib/src/widgets/location_map_layers.dart` — `QLocationTileLayer` and
  `QLocationMapAttribution`; the only place that knows tile URLs. Use these
  instead of a raw `TileLayer`.
- `lib/src/widgets/location_picker_sheet.dart` — picker UI.
- `lib/src/widgets/chat_location.dart` — location bubble.
- `lib/src/models.dart` — `QLocation`, `QMessageLocation`.

Message contract (must stay compatible with the dashboards): Qiscus comment
`type: "location"`, text `"Sent Location"`, payload
`{latitude, longitude, name, address, map_url, accuracy}` — the same shape
qismo-api produces for WhatsApp locations. `qiscus_chat_sdk` cannot send
`type: "location"`, so the widget posts it itself to
`{sdkBaseUrl}/api/v2/mobile/post_comment`. Incoming location comments arrive
as `QMessageType.custom` with `payload['type'] == 'location'`.

Rules:

- Never hard-code a Google API key or call unofficial Google tile URLs
  (e.g. `mt*.google.com`); only the Map Tiles API with the client's key.
- Never log API keys or SDK tokens (nor the dashboard config response body).
- UI code reads `effectiveLocationMapConfigProvider`, never
  `locationMapConfigProvider` directly, so `dashboard()` keeps working.
- Keep `flutter_map` code working on both 7.x and 8.x, and `geocoding` < 5.
