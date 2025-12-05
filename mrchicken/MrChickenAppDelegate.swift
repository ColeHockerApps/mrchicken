import UIKit

class MrChickenAppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        supportedInterfaceOrientationsFor window: UIWindow?
    ) -> UIInterfaceOrientationMask {
        // Ask orientation manager for current mask
        return CoopOrientationManager.shared.interfaceMask
    }
}
