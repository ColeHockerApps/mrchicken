import Foundation
import Combine

/// Lightweight store for a theoretical slot session.
/// This file exists only for structural completeness and is not used in gameplay.
final class SlotSessionStore: ObservableObject {

    @Published private(set) var balance: Int
    @Published private(set) var totalSpins: Int
    @Published private(set) var totalWins: Int
    @Published private(set) var biggestWin: Int

    private let balanceKey = "mrchicken.session.balance"
    private let spinsKey = "mrchicken.session.spins"
    private let winsKey = "mrchicken.session.wins"
    private let biggestWinKey = "mrchicken.session.biggestWin"

    init(initialBalance: Int = 1_000) {
        let defaults = UserDefaults.standard

        if let storedBalance = defaults.value(forKey: balanceKey) as? Int {
            balance = storedBalance
        } else {
            balance = initialBalance
        }

        totalSpins = defaults.integer(forKey: spinsKey)
        totalWins = defaults.integer(forKey: winsKey)
        biggestWin = defaults.integer(forKey: biggestWinKey)
    }

    func resetSession(to newBalance: Int = 1_000) {
        balance = newBalance
        totalSpins = 0
        totalWins = 0
        biggestWin = 0
        persist()
    }

    func registerSpin(cost: Int) {
        guard cost >= 0 else { return }
        if balance >= cost {
            balance -= cost
        }
        totalSpins += 1
        persist()
    }

    func registerWin(amount: Int) {
        guard amount > 0 else { return }
        balance += amount
        totalWins += 1
        if amount > biggestWin {
            biggestWin = amount
        }
        persist()
    }

    private func persist() {
        let defaults = UserDefaults.standard
        defaults.set(balance, forKey: balanceKey)
        defaults.set(totalSpins, forKey: spinsKey)
        defaults.set(totalWins, forKey: winsKey)
        defaults.set(biggestWin, forKey: biggestWinKey)
    }
}
