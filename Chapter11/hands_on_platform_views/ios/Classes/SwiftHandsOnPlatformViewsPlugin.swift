import Flutter
import UIKit

public class SwiftHandsOnPlatformViewsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let viewFactory = HandsOnTextViewFactory()
    registrar.register(viewFactory, withId: "com.example.handson/textview")
  }
}
