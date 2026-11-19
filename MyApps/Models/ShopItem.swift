//
//  ShopItem.swift
//  MyApps
//

import Foundation

enum ShopItemCategory: String {
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
