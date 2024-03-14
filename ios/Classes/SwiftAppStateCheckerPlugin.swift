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
          case .background, .inactive:
             result(1)
          case .active:
              result(0)
          default:
              result(-1)
              break
      }
    }
    result(-1)
  }
}
