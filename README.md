# Qiscus Multichannel Widget

## Requirements

- dart sdk: >=2.16.0 <3.0.0
- flutter sdk: >=2.10.0

## Installation

```
# Qiscus Multichannel main package
flutter pub add qiscus_multichannel_widget
```

## How To Use

### Initialization

In order to use `QiscusMultichannelWidget`, you need to initialize it with your AppID (`YOUR_APP_ID`). Get more information to get AppID from [Qiscus Multichannel Chat page](https://multichannel.qiscus.com/)

```dart
// Wrap your outer most component with `QMultichannelProvider`
// for example
import 'package:qiscus_multichannel_widget/qiscus_multichannel_widget.dart';

QMultichannelProvider(
  appId: appId,
  builder: (context) {
    return MaterialApp(
      home: _buildNavigator(),
    );
  },
);
```

After the initialization, you can access all the widget's functions.

### Set The User

Set UserId before start the chat, this is mandatory.

```dart
QMultichannelConsumer(
  builder: (_, QMultichannel ref) {
    ref.setUser(
      userId: 'guest-1001',
      displayName: 'guest-1001',
    );
    ref.initiateChat();

    return Container();
  },
),
```

### Get Login Status

Use this function to check whether the user has already logged in.

```dart
QMultichannelConsumer(
  builder: (_, QMultichannel ref) {
    if (ref.account.hasValue == true) {
      // User already logged in
    }
    return Container();
  },
),
```

### Start Chat

Use this function to start a chat.

```dart
QMultichannelConsumer(
  builder: (_, QMultichannel ref) {
    ref.initiateChat();
    return Container();
  },
),
```

### Clear User

Use this function to clear the logged-in users.

```dart
QMultichannelConsumer(
  builder: (_, QMultichannel ref) {
    ref.clearUser();
    return Container();
  },
),
```

### Share Location

Customers can share a location from the attachment menu (**Image**, **File**,
**Location**). The **Location** item opens a map picker: a pin fixed at the
centre of the map, a **Use current location** button (GPS), a GPS accuracy
indicator, the reverse-geocoded address and a **Send location** button.

The feature is **opt-in** with a single parameter, `shareLocation`. It is
`null` by default (feature off), so apps that upgrade the widget do not
suddenly need location permissions. Setting it turns the **Location** menu on
and picks the map provider at the same time (see *Map provider* below):

```dart
QMultichannelProvider(
  appId: appId,
  shareLocation: const QLocationMapConfig.openStreetMap(),
  builder: (context) => MaterialApp(home: _buildNavigator()),
);
```

When `shareLocation` is set, the consuming app **must** declare the
location permissions itself:

- **Android** (`android/app/src/main/AndroidManifest.xml`, inside `<manifest>`):

  ```xml
  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
  ```

- **iOS** (`ios/Runner/Info.plist`):

  ```xml
  <key>NSLocationWhenInUseUsageDescription</key>
  <string>Your location is used only when you choose to share it in the chat.</string>
  ```

  Without this key iOS refuses the permission request (and App Store review
  rejects apps that link location APIs without a purpose string).

If permission is denied or location services are off, the picker explains it
and offers a button to open the relevant settings; the customer can still pick a
location by moving the map.

The message is sent as a Qiscus comment with `type: "location"` (the same format
the Omnichannel dashboard already renders for WhatsApp locations):

```json
{
  "comment": "Sent Location",
  "type": "location",
  "payload": {
    "latitude": -6.175392,
    "longitude": 106.827153,
    "name": "Monas",
    "address": "Gambir, Central Jakarta, Jakarta, Indonesia",
    "map_url": "https://maps.google.com/?q=-6.175392,106.827153",
    "accuracy": 12.5
  }
}
```

- `latitude` / `longitude` are rounded to 6 decimals.
- `name` / `address` come from the device's reverse geocoder; both fall back to
  `"Location"` when it fails or times out.
- `accuracy` is the GPS accuracy in metres when the pin is on the GPS fix, and
  `null` when the customer picked the point manually by moving the map.

You can also send a location from code:

```dart
ref.read(QMultichannel.provider).sendLocationMessage(
  QLocation(
    latitude: -6.175392,
    longitude: 106.827153,
    name: 'Monas',
    address: 'Gambir, Central Jakarta',
  ),
);
```

#### Map provider (2 options)

The map in the picker and in the location bubble supports two tile sources,
chosen by the value given to `shareLocation`:

| | Option 1: OpenStreetMap | Option 2: Google Maps |
|---|---|---|
| Config | `QLocationMapConfig.openStreetMap()` | `QLocationMapConfig.google(apiKey: ...)` |
| Cost | Free | Billed to **your own** Google Cloud project |
| API key | Not needed | **Required, owned by the client app** |
| Limits | [OSM tile usage policy](https://operations.osmfoundation.org/policies/tiles/) | Google Maps Platform quotas/pricing |

**Option 1: OpenStreetMap (free).** No API key needed. Tiles
come from the public server `https://tile.openstreetmap.org`, with the
attribution "© OpenStreetMap contributors" and the user agent package
`com.qiscus.multichannel_widget`. That server is a donated, best-effort service:
no heavy usage, no bulk downloading, no SLA. Apps with many users should
consider option 2 or their own tile provider.

```dart
QMultichannelProvider(
  appId: appId,
  shareLocation: const QLocationMapConfig.openStreetMap(),
  builder: (context) => MaterialApp(home: _buildNavigator()),
);
```

**Option 2: Google Maps (client's own API key).** The widget uses the
[Google Map Tiles API](https://developers.google.com/maps/documentation/tile/2d-tiles-overview)
(2D roadmap/satellite/terrain tiles). Qiscus does **not** provide a key: the
client must create one in their own Google Cloud project, enable billing and
the **Map Tiles API**, and pass it in:

```dart
QMultichannelProvider(
  appId: appId,
  shareLocation: const QLocationMapConfig.google(
    apiKey: 'YOUR_GOOGLE_MAPS_API_KEY',
    mapType: 'roadmap', // 'roadmap' | 'satellite' | 'terrain'
    language: 'en-US',
    region: 'ID',
    // If the key is restricted to your app, send the matching headers, e.g.
    // headers: {'X-Ios-Bundle-Identifier': 'com.example.app'},
    // headers: {'X-Android-Package': 'com.example.app',
    //           'X-Android-Cert': '<SHA-1 of the signing certificate>'},
  ),
  builder: (context) => MaterialApp(home: _buildNavigator()),
);
```

- The widget creates one tile session (`POST /v1/createSession`) per config and
  reuses it for the picker and every location bubble; it is renewed before it
  expires. Tile requests count towards **your** Google Maps Platform usage.
- The key ships inside the app binary: restrict it in Google Cloud Console
  (API restriction to Map Tiles API, plus application restriction if you send
  the headers above).
- If the key is invalid or the session cannot be created, the map background
  stays empty (the pin, GPS and sending still work) and the error from Google is
  printed with `debugPrint` (the key is not logged).
- The widget shows the attribution "Google · Map data ©YEAR Google". You are
  responsible for meeting Google's
  [Map Tiles API policies](https://developers.google.com/maps/documentation/tile/policies)
  (logo and attribution requirements) in your app.
- Addresses always come from the device's own geocoder (free, no key), for
  both options. Tapping a location bubble opens `map_url` in Google Maps or the
  browser, which needs no key.
