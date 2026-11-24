//
//  MyAppsApp.swift
//  MyApps
//
//  Created by GaoZiHan on 2026/11/11.
//  This code was updated using GitHub Copilot: startup reset behavior.
//  The app entry structure and main navigation approach are my own.
//

import SwiftUI

@main
struct MyAppsApp: App {
    @State private var showMainView = false
    @State private var openingCharacter = Character()

    init() {
        LocalDataStore.shared.resetProgress()
    }

    var body: some Scene {
        WindowGroup {
            if showMainView {
                HomeView(initialCharacter: openingCharacter)
            } else {
                CharacterView(initialCharacter: openingCharacter) { selectedCharacter in
                    openingCharacter = selectedCharacter
                    showMainView = true
                }
            }
        }
    }
}
