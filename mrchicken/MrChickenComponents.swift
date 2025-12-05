import SwiftUI
import Combine

struct MrChickenComponents {

    struct PrimaryButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(MrChickenTheme.Fonts.body(16))
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(MrChickenTheme.Colors.accentStrong)

                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color.white.opacity(0.25), lineWidth: 1)
                    }
                )
                .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
                .shadow(color: MrChickenTheme.Colors.shadow, radius: 12, x: 0, y: 8)
                .shadow(color: MrChickenTheme.Colors.glow.opacity(0.8), radius: 18, x: 0, y: 0)
                .opacity(configuration.isPressed ? 0.9 : 1.0)
                .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
        }
    }

    struct SecondaryButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(MrChickenTheme.Fonts.body(15))
                .foregroundColor(MrChickenTheme.Colors.textPrimary)
                .padding(.horizontal, 18)
                .padding(.vertical, 9)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(Color.black.opacity(0.55))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(Color.white.opacity(0.18), lineWidth: 1)
                        )
                )
                .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
                .opacity(configuration.isPressed ? 0.85 : 1.0)
                .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
        }
    }

    struct TagView: View {
        let text: String
        let icon: String?

        init(_ text: String, icon: String? = nil) {
            self.text = text
            self.icon = icon
        }

        var body: some View {
            HStack(spacing: 6) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 11, weight: .semibold))
                }

                Text(text)
                    .font(MrChickenTheme.Fonts.body(11))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(
                Capsule(style: .continuous)
                    .fill(Color.black.opacity(0.5))
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
            .shadow(color: MrChickenTheme.Colors.shadow, radius: 6, x: 0, y: 4)
        }
    }

    struct GlassCard<Content: View>: View {
        let content: Content

        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        var body: some View {
            content
                .padding(14)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.black.opacity(0.6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .stroke(Color.white.opacity(0.12), lineWidth: 1)
                        )
                        .shadow(color: MrChickenTheme.Colors.shadow, radius: 14, x: 0, y: 10)
                )
        }
    }
}

// Convenience extensions

extension ButtonStyle where Self == MrChickenComponents.PrimaryButtonStyle {
    static var mrChickenPrimary: MrChickenComponents.PrimaryButtonStyle { .init() }
}

extension ButtonStyle where Self == MrChickenComponents.SecondaryButtonStyle {
    static var mrChickenSecondary: MrChickenComponents.SecondaryButtonStyle { .init() }
}

extension View {
    func mrChickenPrimaryButtonStyle() -> some View {
        self.buttonStyle(.mrChickenPrimary)
    }

    func mrChickenSecondaryButtonStyle() -> some View {
        self.buttonStyle(.mrChickenSecondary)
    }
}
