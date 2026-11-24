//
//  CharacterView.swift
//  MyApps
//
//  Created by GaoZiHan on 2026-11-24.
//  This code was generated using GitHub Copilot: character customization interface.
//  The character selections and Continue behavior are my own.

import SwiftUI

struct CharacterView: View {
    @State private var viewModel: CharacterViewModel
    @Environment(\.dismiss) private var dismiss

    let onContinue: (Character) -> Void

    init(
        initialCharacter: Character = Character(),
        onContinue: @escaping (Character) -> Void = { _ in }
    ) {
        _viewModel = State(initialValue: CharacterViewModel(character: initialCharacter))
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
                    dismiss()
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
            CharacterIllustration(
                character: viewModel.character,
                size: 150
            )

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

}
