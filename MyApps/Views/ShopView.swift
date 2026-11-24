//
//  ShopView.swift
//  MyApps
//
//  Created by GaoZiHan on 2026-11-24.
//  This code was updated using GitHub Copilot: procedure-call comment and UI labels.
//  The shop layout and buying interactions are my own.

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
            CharacterIllustration(
                character: homeViewModel.character,
                size: 130
            )

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
                    // PROCEDURE CALL: The shop screen uses equipItem
                    // to equip the selected item during real app use.
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

}
