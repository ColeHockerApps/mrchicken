import SwiftUI
import Combine

struct CoopBoardContainer: View {
    @EnvironmentObject private var paths: CoopPaths
    @EnvironmentObject private var orientation: CoopOrientationManager
    @StateObject private var vm = CoopBoardViewModel()

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

            ZStack {
                Color.black
                    .ignoresSafeArea()

                CoopBoardStageView(
                    startPath: paths.restoreStoredTrail() ?? paths.entryPoint,
                    paths: paths,
                    orientation: orientation
                ) {
                    vm.markReady()
                }
                .opacity(vm.fadeIn ? 1.0 : 0.0)
                .animation(.easeOut(duration: 0.3), value: vm.fadeIn)

                if vm.isReady == false {
                    loadingOverlay
                }
            }

            Color.black
                .opacity(vm.dimLayer)
                .ignoresSafeArea()
                .allowsHitTesting(false)
                .animation(.easeOut(duration: 0.3), value: vm.dimLayer)
        }
        .onAppear {
            vm.onAppear()
        }
    }

    private var loadingOverlay: some View {
        ZStack {
            Color.black.opacity(0.18)
                .ignoresSafeArea()

            VStack(spacing: 10) {
                ProgressView()
                    .scaleEffect(1.4)

                Text("Loading slots…")
                    .font(MrChickenTheme.Fonts.body(15))
                    .foregroundColor(MrChickenTheme.Colors.textPrimary)
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(Color.black.opacity(0.72))
                    .overlay(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(MrChickenTheme.Colors.accent.opacity(0.7), lineWidth: 1.2)
                    )
                    .shadow(color: MrChickenTheme.Colors.shadow, radius: 16, x: 0, y: 10)
                    .shadow(color: MrChickenTheme.Colors.glow, radius: 28, x: 0, y: 0)
            )
        }
        .transition(.opacity)
        .animation(.easeOut(duration: 0.25), value: vm.isReady)
    }
}

final class CoopBoardViewModel: ObservableObject {
    @Published var isReady: Bool = false
    @Published var fadeIn: Bool = false
    @Published var dimLayer: Double = 1.0

    func onAppear() {
        isReady = false
        fadeIn = false
        dimLayer = 1.0

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            guard let self = self else { return }
            self.dimLayer = 0.0
        }
    }

    func markReady() {
        guard isReady == false else { return }
        isReady = true
        fadeIn = true
    }
}
