import Flutter
import UIKit

public class SwiftDailyInspirationQuotesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "daily_inspiration_quotes", binaryMessenger: registrar.messenger())
    let instance = SwiftDailyInspirationQuotesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
