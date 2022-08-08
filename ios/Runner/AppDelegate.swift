import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GMSServices.provideAPIKey("AIzaSyDqOniWo09m6kiba68ntArwGdc3X6grjrU")
      GeneratedPluginRegistrant.register(with:self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
