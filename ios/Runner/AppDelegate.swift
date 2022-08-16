import UIKit
import Flutter
// import Firebase
// import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
          let batteryChannel = FlutterMethodChannel(name: "samples.flutter.dev/battery",
                                                    binaryMessenger: controller.binaryMessenger)
          batteryChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            // This method is invoked on the UI thread.
            // Handle battery messages.
              guard call.method == "getBatteryLevel" else {
                  result(FlutterMethodNotImplemented)
                  return
                }
                self.receiveBatteryLevel(result: result)
          })
    // FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    // override func application(_ application: UIApplication,
    //                           didRegisterForRemoteNotificationsWithDeviceToken deviseToken: Data
    // ){
    //     Messaging.messaging().apnsToken = deviseToken
    //     print("Token: \(deviseToken)")
    //     super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviseToken)
    // }
    
    
    
    private func receiveBatteryLevel(result: FlutterResult) {
      let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
      if device.batteryState == UIDevice.BatteryState.unknown {
        result(FlutterError(code: "UNAVAILABLE",
                            message: "Battery level not available.",
                            details: nil))
      } else {
        result(Int(device.batteryLevel * 100))
      }
    }

}
