//
//  LocalDataStore.swift
//  MyApps
//
//  Created by GaoZiHan on 2026-11-24.
//  This code was updated using GitHub Copilot: reset-progress persistence support.
//  The existing save and load approach is my own.

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

    func resetProgress() {
        defaults.removeObject(forKey: progressKey)
    }
}
