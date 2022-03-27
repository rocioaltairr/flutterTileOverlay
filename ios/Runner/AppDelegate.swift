import UIKit
import Flutter
import GoogleMaps // Add this line!

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyDdC2MR4UMXrztR_ZtoLiXIuok_rWywSnc")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
