import SwiftUI
import Combine

@main
struct MrChickenApp: App {
    @UIApplicationDelegateAdaptor(MrChickenAppDelegate.self) var appDelegate

    @StateObject private var haptics = HapticsManager()
    @StateObject private var paths = CoopPaths()
    private let orientation = CoopOrientationManager.shared

    var body: some Scene {
        WindowGroup {
            MrChickenMainScreen()
                .environmentObject(haptics)
                .environmentObject(paths)
                .environmentObject(orientation)
        }
    }
}
