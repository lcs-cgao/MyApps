//
//  HomeViewModel.swift
//  MyApps
//

import Observation

@Observable
final class HomeViewModel {
    var character = Character()
    var trophyCount = 0

    // Sample values until the question set system is connected.
    let currentQuestionSetSubject = "Math"
    let currentQuestionSetQuestionCount = 10

    func updateCharacter(_ character: Character) {
        self.character = character
    }

    func awardTrophy() {
        trophyCount += 1
    }
}
