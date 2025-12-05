import Foundation
import Combine

/// Payout table for a theoretical slot system.
/// This file exists only for structural completeness and is not used in gameplay.
struct SlotPayoutEntry: Identifiable, Hashable {
    let id = UUID()
    let symbolName: String
    let count: Int
    let reward: Int
}

enum SlotPayoutTable {

    static let egg3 = SlotPayoutEntry(
        symbolName: "egg",
        count: 3,
        reward: 10
    )

    static let egg4 = SlotPayoutEntry(
        symbolName: "egg",
        count: 4,
        reward: 20
    )

    static let egg5 = SlotPayoutEntry(
        symbolName: "egg",
        count: 5,
        reward: 40
    )

    static let chicken3 = SlotPayoutEntry(
        symbolName: "chicken",
        count: 3,
        reward: 15
    )

    static let chicken4 = SlotPayoutEntry(
        symbolName: "chicken",
        count: 4,
        reward: 30
    )

    static let chicken5 = SlotPayoutEntry(
        symbolName: "chicken",
        count: 5,
        reward: 60
    )

    static let corn3 = SlotPayoutEntry(
        symbolName: "corn",
        count: 3,
        reward: 12
    )

    static let corn4 = SlotPayoutEntry(
        symbolName: "corn",
        count: 4,
        reward: 24
    )

    static let corn5 = SlotPayoutEntry(
        symbolName: "corn",
        count: 5,
        reward: 48
    )

    static let feather3 = SlotPayoutEntry(
        symbolName: "feather",
        count: 3,
        reward: 8
    )

    static let feather4 = SlotPayoutEntry(
        symbolName: "feather",
        count: 4,
        reward: 16
    )

    static let feather5 = SlotPayoutEntry(
        symbolName: "feather",
        count: 5,
        reward: 32
    )

    static let goldenEgg3 = SlotPayoutEntry(
        symbolName: "golden_egg",
        count: 3,
        reward: 40
    )

    static let goldenEgg4 = SlotPayoutEntry(
        symbolName: "golden_egg",
        count: 4,
        reward: 80
    )

    static let goldenEgg5 = SlotPayoutEntry(
        symbolName: "golden_egg",
        count: 5,
        reward: 160
    )

    static let wildAny3 = SlotPayoutEntry(
        symbolName: "wild",
        count: 3,
        reward: 0
    )

    static let bonusAny3 = SlotPayoutEntry(
        symbolName: "bonus",
        count: 3,
        reward: 0
    )

    static let all: [SlotPayoutEntry] = [
        egg3, egg4, egg5,
        chicken3, chicken4, chicken5,
        corn3, corn4, corn5,
        feather3, feather4, feather5,
        goldenEgg3, goldenEgg4, goldenEgg5,
        wildAny3, bonusAny3
    ]
}
