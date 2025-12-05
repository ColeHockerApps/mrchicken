import SwiftUI
import Combine

struct LoadingScreen: View {
    var onFinished: (() -> Void)?

    private let duration: TimeInterval = 3.0

    @State private var progress: CGFloat = 0.0
    @State private var animationStarted = false

    @State private var reel1Spin = false
    @State private var reel2Spin = false
    @State private var reel3Spin = false

    @State private var fadeOut = false

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

            VStack(spacing: 28) {
                Spacer(minLength: 60)

                reelsStrip

                Spacer()

                progressSection

                Spacer().frame(height: 32)
            }
            .padding(.horizontal, 24)
            .opacity(fadeOut ? 0.0 : 1.0)
            .scaleEffect(fadeOut ? 0.97 : 1.0)
        }
        .onAppear {
            startAnimationIfNeeded()
        }
    }

    private var reelsStrip: some View {
        HStack(spacing: 14) {
            reelView(
                symbolName: "e1",
                isSpinning: reel1Spin,
                delayGlow: 0.0
            )
            reelView(
                symbolName: "e2",
                isSpinning: reel2Spin,
                delayGlow: 0.1
            )
            reelView(
                symbolName: "e3",
                isSpinning: reel3Spin,
                delayGlow: 0.2
            )
        }
        .padding(.horizontal, 8)
    }

    private func reelView(symbolName: String, isSpinning: Bool, delayGlow: Double) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(Color.black.opacity(0.82))
                .overlay(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .stroke(MrChickenTheme.Colors.accent.opacity(0.8), lineWidth: 1.4)
                )
                .shadow(color: MrChickenTheme.Colors.shadow, radius: 14, x: 0, y: 10)
                .shadow(color: MrChickenTheme.Colors.glow.opacity(0.8), radius: 26, x: 0, y: 0)

            Image(symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
                .shadow(radius: 8)
                .offset(y: isSpinning ? 10 : -10)
                .rotationEffect(.degrees(isSpinning ? 2 : -2))
                .scaleEffect(isSpinning ? 1.02 : 0.98)
                .animation(
                    Animation.easeInOut(duration: 0.35)
                        .repeatForever(autoreverses: true)
                        .delay(delayGlow),
                    value: isSpinning
                )
        }
        .frame(width: 110, height: 130)
    }

    private var progressSection: some View {
        VStack(spacing: 10) {
            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white.opacity(0.16))
                        .frame(height: 10)

                    Capsule()
                        .fill(MrChickenTheme.Colors.accent)
                        .frame(width: proxy.size.width * progress, height: 10)
                        .shadow(color: MrChickenTheme.Colors.glow, radius: 6, x: 0, y: 0)
                }
            }
            .frame(height: 10)
            .padding(.horizontal, 16)

            Text("Loading slots…")
                .font(MrChickenTheme.Fonts.body(14))
                .foregroundColor(MrChickenTheme.Colors.textSecondary)
        }
    }

    private func startAnimationIfNeeded() {
        guard !animationStarted else { return }
        animationStarted = true

        reel1Spin = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            reel2Spin = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            reel3Spin = true
        }

        withAnimation(.linear(duration: duration)) {
            progress = 1.0
        }

        let fadeStart = max(0.0, duration - 0.3)
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeStart) {
            withAnimation(.easeInOut(duration: 0.3)) {
                fadeOut = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            onFinished?()
        }
    }
}
