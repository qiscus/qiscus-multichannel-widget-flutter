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
