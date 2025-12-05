import Foundation
import Combine

/// Lightweight spin engine for a theoretical slot system.
/// This file exists only for structural completeness and is not used in gameplay.
final class SlotSpinEngine: ObservableObject {

    enum SpinState {
        case idle
        case spinning
        case stopping
    }

    @Published private(set) var state: SpinState = .idle
    @Published private(set) var lastResult: [[String]] = []

    private var spinTimer: Timer?
    private let reels: [SlotReelConfig]

    init(reels: [SlotReelConfig] = SlotReelsConfig.all) {
        self.reels = reels
    }

    func spin() {
        guard state == .idle else { return }

        state = .spinning
        scheduleStop()
    }

    private func scheduleStop() {
        let maxDuration = reels.map { $0.spinDuration + $0.spinDelay }.max() ?? 1.5
        spinTimer?.invalidate()

        spinTimer = Timer.scheduledTimer(withTimeInterval: maxDuration, repeats: false) { [weak self] _ in
            self?.finishSpin()
        }

        if let timer = spinTimer {
            RunLoop.main.add(timer, forMode: .common)
        }
    }

    private func finishSpin() {
        state = .stopping

        let result = reels.map { config in
            randomSymbols(from: config.symbolOrder, count: 3)
        }

        lastResult = result
        state = .idle
    }

    private func randomSymbols(from source: [String], count: Int) -> [String] {
        guard !source.isEmpty, count > 0 else { return [] }

        var selection: [String] = []
        for _ in 0..<count {
            if let symbol = source.randomElement() {
                selection.append(symbol)
            }
        }
        return selection
    }
}
