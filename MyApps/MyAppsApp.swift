//
//  MyAppsApp.swift
//  MyApps
//
//  Created by GaoZiHan on 2026/11/11.
//

import SwiftUI

@main
struct MyAppsApp: App {
    @State private var showMainView = false
    @State private var openingCharacter = LocalDataStore.shared.loadProgress().character

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
