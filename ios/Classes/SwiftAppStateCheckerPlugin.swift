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
              result(3)
          case .background:
             result(2)
          case .active:
              result(1)
          default:
              result(0)
              break
      }
    }
    result(0)
  }
}
