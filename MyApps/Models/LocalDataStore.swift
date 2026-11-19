//
//  LocalDataStore.swift
//  MyApps
//

import Foundation

final class LocalDataStore {
    static let shared = LocalDataStore()

    private let defaults: UserDefaults
    private let progressKey = "MyApps.savedAppProgress"

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func loadProgress() -> AppProgress {
        guard let data = defaults.data(forKey: progressKey) else {
            return .empty
        }

        do {
            return try JSONDecoder().decode(AppProgress.self, from: data)
        } catch {
            return .empty
        }
    }

    func saveProgress(_ progress: AppProgress) {
        do {
            let data = try JSONEncoder().encode(progress)
            defaults.set(data, forKey: progressKey)
        } catch {
            print("Unable to save app progress: \(error.localizedDescription)")
        }
    }
}
