//
//  ShopView.swift
//  MyApps
//

import SwiftUI
import Observation

struct ShopView: View {
    @Bindable var homeViewModel: HomeViewModel

    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                trophyBalanceArea
                characterPreview

                if homeViewModel.shopViewModel.purchaseMessage.isEmpty == false {
                    Text(homeViewModel.shopViewModel.purchaseMessage)
                        .font(.subheadline.bold())
                        .foregroundStyle(.purple)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                shopSection(for: ShopItemCategory.shirt)
                shopSection(for: ShopItemCategory.hairstyle)
                shopSection(for: ShopItemCategory.hat)
                shopSection(for: ShopItemCategory.glasses)
                shopSection(for: ShopItemCategory.accessory)
            }
            .padding()
        }
        .background(Color.green.opacity(0.12))
        .navigationTitle("Character Shop")
    }

    private var trophyBalanceArea: some View {
        Label(
            "\(homeViewModel.trophyCount) trophies",
            systemImage: "trophy.fill"
        )
        .font(.title3.bold())
        .foregroundStyle(.orange)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var characterPreview: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(skinToneColor)
                    .frame(width: 130, height: 130)

                VStack(spacing: 8) {
                    Text(hairSymbol)
                        .font(.system(size: 38))

                    HStack(spacing: 22) {
                        Circle()
                            .fill(eyeColor)
                            .frame(width: 13, height: 13)
                        Circle()
                            .fill(eyeColor)
                            .frame(width: 13, height: 13)
                    }
                }

                if homeViewModel.character.accessories == "Hat"
                    || homeViewModel.character.accessories == "Blue Hat"
                    || homeViewModel.character.accessories == "Crown" {
                    Text(hatSymbol)
                        .font(.system(size: 42))
                        .offset(y: -66)
                }

                if homeViewModel.character.accessories == "Glasses"
                    || homeViewModel.character.accessories == "Round Glasses"
                    || homeViewModel.character.accessories == "Sun Glasses" {
                    Text("👓")
                        .font(.system(size: 28))
                        .offset(y: 15)
                }

                if homeViewModel.character.accessories == "Backpack"
                    || homeViewModel.character.accessories == "Necklace" {
                    Text(accessorySymbol)
                        .font(.system(size: 32))
                        .offset(x: 55, y: 45)
                }
            }

            Text(outfitSymbol)
                .font(.system(size: 44))

            Text(homeViewModel.character.accessories)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private func shopSection(for category: ShopItemCategory) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(category.rawValue)
                .font(.title3.bold())

            ForEach(homeViewModel.shopViewModel.availableItems) { item in
                if item.category == category {
                    shopItemRow(item)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.yellow.opacity(0.25))
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    private func shopItemRow(_ item: ShopItem) -> some View {
        HStack {
            Text(item.symbol)
                .font(.title)
                .frame(width: 44)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)

                if homeViewModel.shopViewModel.isEquipped(item) {
                    Text("Equipped")
                        .font(.caption.bold())
                        .foregroundStyle(.green)
                } else if homeViewModel.shopViewModel.isPurchased(item) {
                    Text("Unlocked")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                } else {
                    Label(
                        "\(item.trophyPrice)",
                        systemImage: "trophy.fill"
                    )
                    .font(.caption.bold())
                    .foregroundStyle(.orange)
                }
            }

            Spacer()

            if homeViewModel.shopViewModel.isPurchased(item) {
                Button(
                    homeViewModel.shopViewModel.isEquipped(item)
                        ? "Equipped"
                        : "Equip"
                ) {
                    homeViewModel.shopViewModel.equipItem(item)
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)
                .disabled(homeViewModel.shopViewModel.isEquipped(item))
            } else {
                Button("Buy") {
                    homeViewModel.shopViewModel.purchaseItem(item)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
            }
        }
        .padding(.vertical, 6)
    }

    private var skinToneColor: Color {
        switch homeViewModel.character.skinTone {
        case "Light":
            return Color(red: 1.0, green: 0.82, blue: 0.68)
        case "Dark":
            return Color(red: 0.38, green: 0.20, blue: 0.10)
        default:
            return Color(red: 0.72, green: 0.45, blue: 0.28)
        }
    }

    private var eyeColor: Color {
        switch homeViewModel.character.eyeColor {
        case "Blue":
            return .blue
        case "Green":
            return .green
        default:
            return .brown
        }
    }

    private var hairSymbol: String {
        if homeViewModel.character.hairstyle.contains("Ponytail") {
            return "🎀"
        }
        if homeViewModel.character.hairstyle.contains("Curly") {
            return "〰️"
        }
        return "🧢"
    }

    private var outfitSymbol: String {
        if homeViewModel.character.outfit.contains("Sporty") {
            return "🎽"
        }
        if homeViewModel.character.outfit.contains("Fancy") {
            return "👔"
        }
        if homeViewModel.character.outfit.contains("Red Shirt") {
            return "👕"
        }
        return "👕"
    }

    private var hatSymbol: String {
        if homeViewModel.character.accessories == "Crown" {
            return "👑"
        }
        return "🧢"
    }

    private var accessorySymbol: String {
        if homeViewModel.character.accessories == "Necklace" {
            return "📿"
        }
        return "🎒"
    }
}
