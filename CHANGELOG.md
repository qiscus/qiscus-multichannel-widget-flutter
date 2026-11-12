## 1.5.0

- Add share location: the attachment menu gets a **Location** item that opens a map picker
  (centre pin, "Use current location", GPS accuracy indicator, reverse-geocoded address,
  "Send location"). Opt-in with one parameter, `QMultichannelProvider(shareLocation: ...)`;
  `null` (default) keeps it off. Host apps must declare the location permissions (see README).
- Two map providers: `QLocationMapConfig.openStreetMap()` (free, public OSM tiles) or
  `QLocationMapConfig.google(apiKey: ...)` (Google Map Tiles API with the client's own key).
- Location messages use the standard Qiscus format (`type: "location"`, payload
  `latitude/longitude/name/address/map_url`, plus `accuracy`), already rendered by the
  Omnichannel dashboard; incoming ones show as a map bubble, and replies preview "Location".
- New public API: `QLocation`, `QMessageLocation`, `QLocationMapConfig`, `QMapTileSource`,
  `sendLocationMessage(QLocation)`.
- New dependencies: `flutter_map` (>=7 <9), `latlong2`, `geolocator`, `geocoding` (<5).

## 1.4.0

- Add multiline chat composer: Return inserts a new line, the text field grows up to 3 lines
  and then scrolls, and the attach/send buttons stay aligned to the bottom of the field.
- Dismiss the keyboard by dragging the chat history (needed on iOS now that Return adds a line).
- Add realtime indicators in the chat room: read and delivered receipts on sent messages, plus
  agent typing and online/offline status in the app bar.

## 1.3.7

- Fix `MissingPluginException` crash when opening the chat room on builds that resolve
  `flutter_secure_storage_x_platform_interface` 1.4.2+: the Dart side calls method channel
  `plugins.dr1009.com/flutter_secure_storage` while the native plugin shipped in
  `flutter_secure_storage_x` 10.x/11.x only registers
  `plugins.it_nomads.com/flutter_secure_storage`. The transitive dependency is now pinned to
  `>=1.4.1 <1.4.2` — a plain dependency, so the constraint also applies to the resolution of
  host apps (affects Android, iOS and macOS builds; no API change in the widget).
- Sync `example/` iOS project with Flutter 3.44 (implicit engine delegate, iOS deployment
  target 13.0).

## 1.3.6

- Fix crash when opening chat room after initiateChat() (regression from 1.3.5 — MessagesNotifier no longer reads its own state inside build())
- Fix locally-sent messages disappearing when initiateChat() runs again (merge, not overwrite, on same-room reload)
- Add example: two live-chat channels in one app (each channel isolated) + login error handling demo

## 1.3.5

- Fix secure session per channel (appId + channelId + userId), with migration from legacy key
- Fix session overwritten when switching between channels in the same app
- Fix SDK instance shared between channel widgets (isolate QiscusSDK per channel widget)
- Fix clearUser() not removing secure session key on logout
- Fix room load error hidden by dummy room — errors now propagate to host app
- Fix unbounded retry loop on room load timeout (bounded retry with backoff)
- Fix crash on identity token parse when HTTP status is not 200
- Fix crash when userId contains underscore
- Fix draft text lost on every chat page rebuild (QChatForm now stateful)
- Fix newly sent message disappearing when initiateChat() runs again

## 1.3.4

- Change secure storage library

## 1.3.3

- Fix avatar not changing

## 1.3.2

- Update dependencies
- Fix not loading more messages

## 1.3.1

- add functionality to call function without using QMultichannelConsumer
- fix support for user extras data

## 1.3.0

- added support for message type reply
- fix unable to hide system event

## 1.2.2

- update qiscus chat sdk to latest version

## 1.2.1

- update qiscus chat sdk to latest version

## 1.2.0

- added support to config right bubble chat avatar
- added support to style button on chat with button type

## 1.1.10

- fix not showing remote avatar

## 1.1.9

- fix message not appearing / realtime

## 1.1.8

- fix not loading newest messages
- fix not infinite loading

## 1.1.7

- fix not loading room data on hardware back button

## 1.1.6

- fix undefined StrokeAlign

## 1.1.5

- fix not loading room data properly when using imperative flutter navigator

## 1.1.4

- improve handling android navigation back button

## 1.1.3

- upgrade qiscus sdk and flutter riverpod to latest version
- fix not unsubscribe to some qiscus event
- organize providers to it's own files

## 1.1.2

- upgrade flutter_secure_storage to latest version

## 1.1.1

- fix flutter_secure_storage from removing all non sdk items

## 1.1.0

- add message buttons type support
- add message carousel type support

## 1.0.6

- add `account.properties`

## 1.0.5

- fix could not set `userProperties` when initiating

## 1.0.4

- fix message status now default to read
- fix not getting initial messages
- implemented url rendering

## 1.0.3

- fix not opening attachment popup dialog

## 1.0.2

- upgrade dependencies
- fix wrong timestamp

## 1.0.1

- fix time info always on minutes seven

## 1.0.0

- fix back button on appbar not working
- fix unable to delete message

## 1.0.0-beta.5

- fix sessional room feature not working
- fix using different channel not working
- fix theme not applied to some UI
- fix sending empty message
- implemented empty state
- implemented infinite loading more message

## 1.0.0-beta.4

- fix cannot change avatar
- update to latest qiscus sdk for realtime issue

## 1.0.0-beta.3

- Fix missing assets
- Fix not receiving new message

## 1.0.0-beta.2

- Add upload attachment functionality

## 1.0.0-beta.1

- Beta public release

## 0.0.1

Initial release
