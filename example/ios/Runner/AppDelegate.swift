import Flutter
import UIKit
import firebase_messaging

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // With UIScene, plugins are registered after this method returns, but iOS
    // needs the UNUserNotificationCenter delegate before launch completes.
    // Without this, onMessage/onMessageOpenedApp never fire (flutterfire #18204).
    FLTFirebaseMessagingPlugin.configureNotificationCenterDelegate()
    application.registerForRemoteNotifications()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
