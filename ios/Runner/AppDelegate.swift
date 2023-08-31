import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    MethodChannelUtil(messenger: controller.binaryMessenger)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

public class MethodChannelUtil {
    init(messenger: FlutterBinaryMessenger) {
        // 1、 创建一个MethodChannel
        let channel = FlutterMethodChannel(name : "methodChannel", binaryMessenger: messenger)
        // 2、注册MethodChannel实例
        channel.setMethodCallHandler{(call:FlutterMethodCall, result:@escaping FlutterResult) in
        // 3、方法调用
            if (call.method=="getFlutterInfo") {
                result("hello from iOS")
            }
        }
    }
}