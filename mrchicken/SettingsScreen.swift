import SwiftUI
import Combine

struct SettingsScreen: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var haptics: HapticsManager
    @EnvironmentObject private var paths: CoopPaths
    @Environment(\.openURL) private var openURL

    @AppStorage("mrchicken.settings.soundsEnabled") private var soundsEnabled: Bool = true
    @AppStorage("mrchicken.settings.hapticsEnabled") private var hapticsEnabledValue: Bool = true

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    MrChickenTheme.Colors.backgroundTop,
                    MrChickenTheme.Colors.backgroundBottom
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                header

                ScrollView {
                    VStack(spacing: 20) {
                        soundSection
                        privacySection
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                }
            }
        }
    }

    private var header: some View {
        HStack {
            Button {
                if hapticsEnabledValue {
                    haptics.tap()
                }
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(Color.black.opacity(0.45))
                    )
            }

            Spacer()

            Text("Settings")
                .font(MrChickenTheme.Fonts.title(22))
                .foregroundColor(MrChickenTheme.Colors.textPrimary)

            Spacer()

            // Spacer button placeholder for symmetry
            Color.clear
                .frame(width: 32, height: 32)
        }
        .padding(.horizontal, 20)
        .padding(.top, 18)
        .padding(.bottom, 10)
        .background(
            Color.black.opacity(0.25)
                .ignoresSafeArea(edges: .top)
        )
    }

    private var soundSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Game")
                .font(MrChickenTheme.Fonts.subtitle(15))
                .foregroundColor(MrChickenTheme.Colors.textPrimary)

            settingRow(
                title: "Sound",
                subtitle: "Toggle game sounds on or off.",
                isOn: $soundsEnabled
            )

            settingRow(
                title: "Haptics",
                subtitle: "Light vibration on taps and actions.",
                isOn: $hapticsEnabledValue
            )
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.black.opacity(0.65))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(Color.white.opacity(0.12), lineWidth: 1)
                )
                .shadow(color: MrChickenTheme.Colors.shadow, radius: 14, x: 0, y: 10)
        )
    }

    private func settingRow(
        title: String,
        subtitle: String,
        isOn: Binding<Bool>
    ) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(MrChickenTheme.Fonts.body(15))
                    .foregroundColor(MrChickenTheme.Colors.textPrimary)

                Text(subtitle)
                    .font(MrChickenTheme.Fonts.body(12))
                    .foregroundColor(MrChickenTheme.Colors.textSecondary)
            }

            Spacer()

            Toggle("", isOn: isOn)
                .labelsHidden()
        }
    }

    private var privacySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Info")
                .font(MrChickenTheme.Fonts.subtitle(15))
                .foregroundColor(MrChickenTheme.Colors.textPrimary)

            Button {
                if hapticsEnabledValue {
                    haptics.tap()
                }
                openURL(paths.privacyPage)
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "shield.lefthalf.filled")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(MrChickenTheme.Colors.accent)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Privacy Policy")
                            .font(MrChickenTheme.Fonts.body(14))
                            .foregroundColor(MrChickenTheme.Colors.textPrimary)

                        Text("Read how your data is handled.")
                            .font(MrChickenTheme.Fonts.body(12))
                            .foregroundColor(MrChickenTheme.Colors.textSecondary)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(MrChickenTheme.Colors.textSecondary)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(Color.black.opacity(0.7))
                )
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.black.opacity(0.65))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(Color.white.opacity(0.12), lineWidth: 1)
                )
                .shadow(color: MrChickenTheme.Colors.shadow, radius: 14, x: 0, y: 10)
        )
    }
}
