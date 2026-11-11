//
//  Character.swift
//  MyApps
//

import Foundation

struct Character: Identifiable {
    let id: UUID = UUID()
    var skinTone: String = "Medium"
    var eyeColor: String = "Brown"
    var hairstyle: String = "Short"
    var hairColor: String = "Brown"
    var outfit: String = "Casual"
    var accessories: String = "None"
}
