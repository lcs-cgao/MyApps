//
//  ShopItem.swift
//  MyApps
//
//  Created by GaoZiHan on 2026-11-24.
//  This code was generated using GitHub Copilot: shop item and category structures.
//  The shop item properties and categories are my own.

import Foundation

enum ShopItemCategory: String, Codable {
    case shirt = "Shirts"
    case hairstyle = "Hairstyles"
    case hat = "Hats"
    case glasses = "Glasses"
    case accessory = "Other Accessories"
}

struct ShopItem: Identifiable {
    let id = UUID()
    let name: String
    let trophyPrice: Int
    let category: ShopItemCategory
    let symbol: String
}
