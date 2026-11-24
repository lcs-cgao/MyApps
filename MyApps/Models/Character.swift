//
//  Character.swift
//  MyApps
//
//  Created by GaoZiHan on 2026-11-24.
//  This code was generated using GitHub Copilot: character data structure setup.
//  The character data and default values are my own.

import Foundation

struct Character: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var skinTone: String = "Medium"
    var eyeColor: String = "Brown"
    var hairstyle: String = "Short"
    var hairColor: String = "Brown"
    var outfit: String = "Casual"
    var accessories: String = "None"
}
