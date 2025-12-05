import Foundation
import Combine
import UIKit

@MainActor
final class CoopOrientationManager: ObservableObject {
    static let shared = CoopOrientationManager()

    enum Mode {
        case flexible     // portrait + landscape
        case landscape    // landscape only
    }

    @Published private(set) var currentMode: Mode = .flexible

    // Main embedded entry
    @Published var mainEntry: URL? = nil

    // Current active path
    @Published var activePath: URL? = nil {
        didSet {
            handleRouteChange()
        }
    }

    private init() {}

    // MARK: - Registration

    func registerMainEntry(_ link: URL) {
        mainEntry = link
        handleRouteChange()
    }

    func updateActivePath(_ link: URL?) {
        activePath = link
    }

    // MARK: - Route → Orientation

    private func handleRouteChange() {
        guard let main = mainEntry else {
            allowFlexible()
            return
        }

        guard let current = activePath else {
            allowFlexible()
            return
        }

        let mainSignature = main.host?.lowercased()
        let currentSignature = current.host?.lowercased()

        if let m = mainSignature,
           let c = currentSignature,
           m == c {
            lockLandscape()
        } else {
            allowFlexible()
        }
    }

    // MARK: - Orientation control

    func allowFlexible() {
        currentMode = .flexible
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue,
                                  forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }

    func lockLandscape() {
        currentMode = .landscape
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue,
                                  forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }

    var interfaceMask: UIInterfaceOrientationMask {
        switch currentMode {
        case .flexible:
            return [.portrait, .landscapeLeft, .landscapeRight]
        case .landscape:
            return [.landscapeLeft, .landscapeRight]
        }
    }
}
