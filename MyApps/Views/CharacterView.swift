//
//  CharacterView.swift
//  MyApps
//

import SwiftUI

struct CharacterView: View {
    @State private var viewModel = CharacterViewModel()

    let onContinue: (Character) -> Void

    init(onContinue: @escaping (Character) -> Void = { _ in }) {
        self.onContinue = onContinue
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                characterPreview

                selectionSection(
                    title: "Skin tone",
                    options: viewModel.skinToneOptions,
                    selectedOption: viewModel.character.skinTone
                ) { selectedOption in
                    viewModel.selectSkinTone(selectedOption)
                }

                selectionSection(
                    title: "Eye color",
                    options: viewModel.eyeColorOptions,
                    selectedOption: viewModel.character.eyeColor
                ) { selectedOption in
                    viewModel.selectEyeColor(selectedOption)
                }

                selectionSection(
                    title: "Hairstyle",
                    options: viewModel.hairstyleOptions,
                    selectedOption: viewModel.character.hairstyle
                ) { selectedOption in
                    viewModel.selectHairstyle(selectedOption)
                }

                selectionSection(
                    title: "Hair color",
                    options: viewModel.hairColorOptions,
                    selectedOption: viewModel.character.hairColor
                ) { selectedOption in
                    viewModel.selectHairColor(selectedOption)
                }

                selectionSection(
                    title: "Outfit",
                    options: viewModel.outfitOptions,
                    selectedOption: viewModel.character.outfit
                ) { selectedOption in
                    viewModel.selectOutfit(selectedOption)
                }

                selectionSection(
                    title: "Accessories",
                    options: viewModel.accessoryOptions,
                    selectedOption: viewModel.character.accessories
                ) { selectedOption in
                    viewModel.selectAccessory(selectedOption)
                }

                Button("Continue") {
                    onContinue(viewModel.character)
                }
                .font(.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.purple)
                .clipShape(Capsule())
            }
            .padding()
        }
        .background(Color.yellow.opacity(0.15))
        .navigationTitle("Create Your Character")
    }

    private var characterPreview: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(skinToneColor)
                    .frame(width: 150, height: 150)

                VStack(spacing: 8) {
                    Text(hairSymbol)
                        .font(.system(size: 42))

                    HStack(spacing: 24) {
                        Circle()
                            .fill(eyeColor)
                            .frame(width: 14, height: 14)
                        Circle()
                            .fill(eyeColor)
                            .frame(width: 14, height: 14)
                    }
                }
            }

            Text(outfitSymbol)
                .font(.system(size: 48))

            Text("\(viewModel.character.hairstyle) \(viewModel.character.hairColor) hair")
            Text("\(viewModel.character.outfit) outfit • \(viewModel.character.accessories)")
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.8))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private func selectionSection(
        title: String,
        options: [String],
        selectedOption: String,
        onSelect: @escaping (String) -> Void
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(options, id: \.self) { option in
                        Button {
                            onSelect(option)
                        } label: {
                            Text(option)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .background(
                                    option == selectedOption
                                        ? Color.orange
                                        : Color.white
                                )
                                .foregroundStyle(
                                    option == selectedOption
                                        ? Color.white
                                        : Color.primary
                                )
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var skinToneColor: Color {
        switch viewModel.character.skinTone {
        case "Light":
            return Color(red: 1.0, green: 0.82, blue: 0.68)
        case "Dark":
            return Color(red: 0.38, green: 0.20, blue: 0.10)
        default:
            return Color(red: 0.72, green: 0.45, blue: 0.28)
        }
    }

    private var eyeColor: Color {
        switch viewModel.character.eyeColor {
        case "Blue":
            return .blue
        case "Green":
            return .green
        default:
            return .brown
        }
    }

    private var hairSymbol: String {
        switch viewModel.character.hairstyle {
        case "Curly":
            return "〰️"
        case "Ponytail":
            return "🎀"
        default:
            return "🧢"
        }
    }

    private var outfitSymbol: String {
        switch viewModel.character.outfit {
        case "Sporty":
            return "⚽️"
        case "Fancy":
            return "👗"
        default:
            return "👕"
        }
    }
}
