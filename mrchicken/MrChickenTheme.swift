import SwiftUI
import Combine

struct MrChickenTheme {

    struct Colors {
        // Background – bright slot-machine vibe
        static let backgroundTop = Color(red: 252/255, green: 216/255, blue: 106/255)
        static let backgroundBottom = Color(red: 247/255, green: 142/255, blue: 47/255)

        // Main accent – eggshell gold
        static let accent = Color(red: 255/255, green: 199/255, blue: 67/255)

        // Secondary accent – deep warm red (chicken theme)
        static let accentStrong = Color(red: 220/255, green: 54/255, blue: 47/255)

        // Text
        static let textPrimary = Color.white
        static let textSecondary = Color.white.opacity(0.75)

        // Slot-style shadow
        static let glow = Color(red: 255/255, green: 240/255, blue: 180/255).opacity(0.65)
        static let shadow = Color.black.opacity(0.25)
    }

    struct Fonts {
        static func title(_ size: CGFloat) -> Font {
            Font.system(size: size, weight: .heavy, design: .rounded)
        }

        static func subtitle(_ size: CGFloat) -> Font {
            Font.system(size: size, weight: .semibold, design: .rounded)
        }

        static func body(_ size: CGFloat) -> Font {
            Font.system(size: size, weight: .medium, design: .rounded)
        }
    }
}
