import Foundation
import Combine

/// Reels configuration for a theoretical slot engine.
/// This file exists only for structural completeness and is not used in gameplay.
struct SlotReelConfig: Identifiable, Hashable {
    let id = UUID()
    let index: Int
    let symbolOrder: [String]
    let spinDuration: TimeInterval
    let spinDelay: TimeInterval
}

enum SlotReelsConfig {

    static let reel1 = SlotReelConfig(
        index: 0,
        symbolOrder: [
            "egg",
            "chicken",
            "corn",
            "feather",
            "egg",
            "golden_egg",
            "feather",
            "corn"
        ],
        spinDuration: 1.4,
        spinDelay: 0.0
    )

    static let reel2 = SlotReelConfig(
        index: 1,
        symbolOrder: [
            "chicken",
            "corn",
            "egg",
            "feather",
            "corn",
            "egg",
            "golden_egg",
            "feather"
        ],
        spinDuration: 1.6,
        spinDelay: 0.05
    )

    static let reel3 = SlotReelConfig(
        index: 2,
        symbolOrder: [
            "corn",
            "egg",
            "feather",
            "chicken",
            "egg",
            "corn",
            "golden_egg",
            "feather"
        ],
        spinDuration: 1.8,
        spinDelay: 0.1
    )

    static let reel4 = SlotReelConfig(
        index: 3,
        symbolOrder: [
            "feather",
            "egg",
            "corn",
            "chicken",
            "egg",
            "feather",
            "golden_egg",
            "corn"
        ],
        spinDuration: 2.0,
        spinDelay: 0.15
    )

    static let all: [SlotReelConfig] = [
        reel1,
        reel2,
        reel3,
        reel4
    ]
}
