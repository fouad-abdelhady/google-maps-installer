import Cocoa
import FlutterMacOS
import url_launcher_macos
@main
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
   override func applicationDidFinishLaunching(_ notification: Notification) {
    // Register plugins
    if let controller = NSApp.mainWindow?.contentViewController as? FlutterViewController {
      UrlLauncherPlugin.register(with: controller.registrar(forPlugin: "UrlLauncherPlugin"))
    }
    
    super.applicationDidFinishLaunching(notification)
  }
}
