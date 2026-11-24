//
//  CharacterViewModel.swift
//  MyApps
//
//  Created by GaoZiHan on 2026-11-24.
//  This code was generated using GitHub Copilot: character selection ViewModel setup.
//  The character choices and selection procedures are my own.

import Observation

@Observable
@MainActor
final class CharacterViewModel {
    var character: Character

    let skinToneOptions = ["Light", "Medium", "Dark"]
    let eyeColorOptions = ["Blue", "Green", "Brown"]
    let hairstyleOptions = ["Short", "Curly", "Ponytail"]
    let hairColorOptions = ["Black", "Brown", "Blonde"]
    let outfitOptions = ["Casual", "Sporty", "Fancy"]
    let accessoryOptions = ["None", "Glasses", "Hat"]

    init(character: Character = Character()) {
        self.character = character
    }

    func selectSkinTone(_ skinTone: String) {
        character.skinTone = skinTone
    }

    func selectEyeColor(_ eyeColor: String) {
        character.eyeColor = eyeColor
    }

    func selectHairstyle(_ hairstyle: String) {
        character.hairstyle = hairstyle
    }

    func selectHairColor(_ hairColor: String) {
        character.hairColor = hairColor
    }

    func selectOutfit(_ outfit: String) {
        character.outfit = outfit
    }

    func selectAccessory(_ accessory: String) {
        character.accessories = accessory
    }
}
