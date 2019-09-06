import Flutter
import UIKit

public class SwiftHandsOnBackgroundProcessPlugin: NSObject, FlutterPlugin {
    static var _registerPlugins: ((FlutterPluginRegistry) -> (Void))?
    var _registrar: FlutterPluginRegistrar
    var _backgroundChannel: FlutterMethodChannel?
    var taskID : UIBackgroundTaskIdentifier? = nil
    var _backgroundRunner: FlutterEngine? = nil
    
    init(registrar: FlutterPluginRegistrar) {
        _registrar = registrar
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.example.handson/plugin_channel", binaryMessenger: registrar.messenger())
        let instance = SwiftHandsOnBackgroundProcessPlugin(registrar: registrar)
        
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public static func setPluginRegistrantCallback(registerPlugins: ((FlutterPluginRegistry) -> (Void))?) {
        _registerPlugins = registerPlugins
    }

public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

    if (call.method == "initBackgroundProcess") {
        guard let args = call.arguments as? NSArray else {
            return
        }
        guard let handle = args[0] as? Int64 else {
            return
        }
        
        executeBackgroundIsolate(handle: handle)
    } else if (call.method == "backgroundIsolateInitialized") {
        if(self.taskID != nil && self.taskID != .invalid) {  
            UIApplication.shared.endBackgroundTask(self.taskID!)
        }
        self.taskID = UIApplication.shared.beginBackgroundTask {
            self.taskID = .invalid
        }
        _backgroundChannel?.invokeMethod("calculate", arguments: nil)
    } else if (call.method == "calculationFinished") {
        if(self.taskID != nil && self.taskID != .invalid) {
            UIApplication.shared.endBackgroundTask(self.taskID!)
            self.taskID = .invalid
        }
        // end background task
    }
}

    private func executeBackgroundIsolate(handle: Int64) {
        
        _backgroundRunner = FlutterEngine.init(
            name: "BackgroundProcess",
            project: nil,
            allowHeadlessExecution: true
        )
        
        guard let info = FlutterCallbackCache.lookupCallbackInformation(handle) else {
            return
        }
        
        let entrypoint = info.callbackName
        let uri = info.callbackLibraryPath
        
        _backgroundRunner!.run(withEntrypoint: entrypoint, libraryURI: uri
        )

        _backgroundChannel = FlutterMethodChannel(
            name: "com.example.handson/background_channel",
            binaryMessenger: _backgroundRunner!
        )
        
        _registrar.addMethodCallDelegate(self, channel: _backgroundChannel!
        )
        
        SwiftHandsOnBackgroundProcessPlugin._registerPlugins?(_backgroundRunner!)
        
        
    }
}
