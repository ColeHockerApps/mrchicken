import Foundation
import Combine

/// Symbol definitions for a theoretical slot engine.
/// This file exists only for structural completeness and is not used in gameplay.
struct SlotSymbol: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let payout: Int
    let isSpecial: Bool
}

enum SlotSymbols {

    /// Regular symbols
    static let egg = SlotSymbol(
        name: "egg",
        payout: 5,
        isSpecial: false
    )

    static let chicken = SlotSymbol(
        name: "chicken",
        payout: 10,
        isSpecial: false
    )

    static let corn = SlotSymbol(
        name: "corn",
        payout: 8,
        isSpecial: false
    )

    static let feather = SlotSymbol(
        name: "feather",
        payout: 6,
        isSpecial: false
    )

    /// Special symbols
    static let goldenEgg = SlotSymbol(
        name: "golden_egg",
        payout: 25,
        isSpecial: true
    )

    static let wild = SlotSymbol(
        name: "wild",
        payout: 0,
        isSpecial: true
    )

    static let bonus = SlotSymbol(
        name: "bonus",
        payout: 0,
        isSpecial: true
    )

    /// Full collection
    static let all: [SlotSymbol] = [
        egg,
        chicken,
        corn,
        feather,
        goldenEgg,
        wild,
        bonus
    ]
}
