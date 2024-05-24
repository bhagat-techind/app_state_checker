import Flutter
import UIKit

public class SwiftAppStateCheckerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "app_state_checker", binaryMessenger: registrar.messenger())
    let instance = SwiftAppStateCheckerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
     if (call.method == "getAppState") {
      switch UIApplication.shared.applicationState {
          case .inactive:
              result(2)
               break
          case .background:
             result(1)
              break
          case .active:
              result(0)
               break
          default:
              result(3)
              break
      }
    } else {
        result(0)
    }
  }
}
