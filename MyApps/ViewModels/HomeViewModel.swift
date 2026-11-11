//
//  HomeViewModel.swift
//  MyApps
//

import Observation

@Observable
final class HomeViewModel {
    var character = Character()
    var trophyCount = 0
    private(set) var currentQuestionSetIndex = 0
    private(set) var questionSetProgression = QuestionSet.questionSetProgression

    var currentQuestionSet: QuestionSet {
        questionSetProgression[currentQuestionSetIndex]
    }

    func updateCharacter(_ character: Character) {
        self.character = character
    }

    func awardTrophy() {
        trophyCount += 1
    }

    func completeCurrentQuestionSet() {
        guard currentQuestionSet.isCompleted == false else {
            return
        }

        questionSetProgression[currentQuestionSetIndex].isCompleted = true

        if currentQuestionSetIndex < questionSetProgression.count - 1 {
            currentQuestionSetIndex += 1
        }
    }
}
