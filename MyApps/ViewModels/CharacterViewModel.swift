//
//  CharacterViewModel.swift
//  MyApps
//

import Observation

@Observable
final class CharacterViewModel {
    var character = Character()

    let skinToneOptions = ["Light", "Medium", "Dark"]
    let eyeColorOptions = ["Blue", "Green", "Brown"]
    let hairstyleOptions = ["Short", "Curly", "Ponytail"]
    let hairColorOptions = ["Black", "Brown", "Blonde"]
    let outfitOptions = ["Casual", "Sporty", "Fancy"]
    let accessoryOptions = ["None", "Glasses", "Hat"]

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
