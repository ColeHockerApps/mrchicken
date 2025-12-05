import Foundation
import Combine

final class CoopPaths: ObservableObject {
    @Published var entryPoint: URL
    @Published var privacyPage: URL

    private let entryKey = "coop.entry.link"
    private let privacyKey = "coop.privacy.link"
    private let trailKey = "coop.trail.link"
    private let marksKey = "coop.trail.marks"

    private var hasStoredTrail = false

    init() {
        let defaults = UserDefaults.standard

        let defaultEntry = "https://mariacamgames.github.io/mrchicken"
        let defaultPrivacy = "https://mariacamgames.github.io/mrchicken-privacy"

        if let saved = defaults.string(forKey: entryKey),
           let url = URL(string: saved) {
            entryPoint = url
        } else {
            entryPoint = URL(string: defaultEntry)!
        }

        if let saved = defaults.string(forKey: privacyKey),
           let url = URL(string: saved) {
            privacyPage = url
        } else {
            privacyPage = URL(string: defaultPrivacy)!
        }
    }

    func updateEntry(_ link: String) {
        guard let url = URL(string: link) else { return }
        entryPoint = url
        UserDefaults.standard.set(link, forKey: entryKey)
    }

    func updatePrivacy(_ link: String) {
        guard let url = URL(string: link) else { return }
        privacyPage = url
        UserDefaults.standard.set(link, forKey: privacyKey)
    }

    func storeTrailIfNeeded(_ link: URL) {
        guard hasStoredTrail == false else { return }
        hasStoredTrail = true

        let defaults = UserDefaults.standard
        if defaults.string(forKey: trailKey) != nil {
            return
        }

        defaults.set(link.absoluteString, forKey: trailKey)
    }

    func restoreStoredTrail() -> URL? {
        let defaults = UserDefaults.standard
        if let saved = defaults.string(forKey: trailKey),
           let url = URL(string: saved) {
            return url
        }
        return nil
    }

    func saveMarks(_ items: [[String: Any]]) {
        UserDefaults.standard.set(items, forKey: marksKey)
    }

    func currentMarks() -> [[String: Any]]? {
        UserDefaults.standard.array(forKey: marksKey) as? [[String: Any]]
    }
}
