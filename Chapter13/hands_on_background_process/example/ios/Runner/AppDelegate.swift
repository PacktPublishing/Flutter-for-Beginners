import UIKit
import Flutter
import hands_on_background_process

func registerPlugins(registry: FlutterPluginRegistry) {
    GeneratedPluginRegistrant.register(with: registry)
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    SwiftHandsOnBackgroundProcessPlugin.setPluginRegistrantCallback(registerPlugins: registerPlugins)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
