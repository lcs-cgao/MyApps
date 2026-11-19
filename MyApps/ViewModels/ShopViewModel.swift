//
//  ShopViewModel.swift
//  MyApps
//

import Foundation
import Observation

@Observable
@MainActor
final class ShopViewModel {
    // MARK: - Character and Trophy State

    var character: Character
    private(set) var trophyBalance: Int
    private(set) var purchasedItemIDs: [UUID] = []
    private(set) var equippedItemIDs: [UUID] = []
    private(set) var purchaseMessage = ""

    // MARK: - Shop Items

    let availableItems: [ShopItem] = [
        ShopItem(name: "Red Shirt", trophyPrice: 2, category: .shirt, symbol: "👕"),
        ShopItem(name: "Sporty Shirt", trophyPrice: 3, category: .shirt, symbol: "🎽"),
        ShopItem(name: "Fancy Shirt", trophyPrice: 4, category: .shirt, symbol: "👔"),
        ShopItem(name: "Curly Hairstyle", trophyPrice: 3, category: .hairstyle, symbol: "〰️"),
        ShopItem(name: "Ponytail Hairstyle", trophyPrice: 4, category: .hairstyle, symbol: "🎀"),
        ShopItem(name: "Blue Hat", trophyPrice: 3, category: .hat, symbol: "🧢"),
        ShopItem(name: "Crown", trophyPrice: 6, category: .hat, symbol: "👑"),
        ShopItem(name: "Round Glasses", trophyPrice: 3, category: .glasses, symbol: "👓"),
        ShopItem(name: "Sun Glasses", trophyPrice: 5, category: .glasses, symbol: "🕶️"),
        ShopItem(name: "Backpack", trophyPrice: 4, category: .accessory, symbol: "🎒"),
        ShopItem(name: "Necklace", trophyPrice: 5, category: .accessory, symbol: "📿")
    ]

    init(initialTrophyBalance: Int, initialCharacter: Character) {
        trophyBalance = initialTrophyBalance
        character = initialCharacter
    }

    // MARK: - Purchasing

    func purchaseItem(_ item: ShopItem) {
        if purchasedItemIDs.contains(item.id) {
            purchaseMessage = "\(item.name) is already unlocked."
            return
        }

        if trophyBalance < item.trophyPrice {
            purchaseMessage = "You need \(item.trophyPrice - trophyBalance) more trophy for \(item.name)."
            return
        }

        trophyBalance -= item.trophyPrice
        purchasedItemIDs.append(item.id)
        purchaseMessage = "\(item.name) unlocked!"
    }

    // MARK: - Equipping

    func equipItem(_ item: ShopItem) {
        if purchasedItemIDs.contains(item.id) == false {
            purchaseMessage = "Purchase \(item.name) before equipping it."
            return
        }

        for existingItem in availableItems {
            if existingItem.category == item.category
                && equippedItemIDs.contains(existingItem.id) {
                equippedItemIDs.removeAll { equippedID in
                    equippedID == existingItem.id
                }
            }
        }

        equippedItemIDs.append(item.id)

        switch item.category {
        case .shirt:
            character.outfit = item.name
        case .hairstyle:
            character.hairstyle = item.name
        case .hat:
            character.accessories = item.name
        case .glasses:
            character.accessories = item.name
        case .accessory:
            character.accessories = item.name
        }

        purchaseMessage = "\(item.name) equipped!"
    }

    func isPurchased(_ item: ShopItem) -> Bool {
        purchasedItemIDs.contains(item.id)
    }

    func isEquipped(_ item: ShopItem) -> Bool {
        equippedItemIDs.contains(item.id)
    }

    // MARK: - Shared Character and Trophy Updates

    func updateCharacter(_ character: Character) {
        self.character = character
    }

    func awardTrophy() {
        trophyBalance += 1
    }
}
