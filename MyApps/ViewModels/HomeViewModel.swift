//
//  HomeViewModel.swift
//  MyApps
//

import Foundation
import Observation

@Observable
@MainActor
final class HomeViewModel {
    let shopViewModel: ShopViewModel
    let historyViewModel: HistoryViewModel
    private let dataStore: LocalDataStore
    private(set) var currentQuestionSetIndex: Int
    private(set) var questionSetProgression: [QuestionSet]
    private(set) var awardedQuestionSetNames: [String]

    init(dataStore: LocalDataStore = .shared) {
        self.dataStore = dataStore
        let savedProgress = dataStore.loadProgress()

        let savedShopViewModel = ShopViewModel(
            initialTrophyBalance: savedProgress.trophyCount,
            initialCharacter: savedProgress.character,
            purchasedItemNames: savedProgress.purchasedItemNames,
            equippedItemNames: savedProgress.equippedItemNames
        )
        let savedHistoryViewModel = HistoryViewModel(
            completedQuestions: savedProgress.completedQuestions,
            incorrectQuestions: savedProgress.incorrectQuestions
        )

        var savedQuestionSetProgression = QuestionSet.questionSetProgression
        for index in savedQuestionSetProgression.indices {
            let setName = savedQuestionSetProgression[index].setName
            if savedProgress.completedQuestionSetNames.contains(setName) {
                savedQuestionSetProgression[index].isCompleted = true
            }
        }

        let savedIndex = savedProgress.currentQuestionSetIndex
        let startingQuestionSetIndex = savedIndex >= 0
            && savedIndex < savedQuestionSetProgression.count
            ? savedIndex
            : 0

        shopViewModel = savedShopViewModel
        historyViewModel = savedHistoryViewModel
        questionSetProgression = savedQuestionSetProgression
        currentQuestionSetIndex = startingQuestionSetIndex
        awardedQuestionSetNames = savedProgress.awardedQuestionSetNames

        shopViewModel.onChange = { [weak self] in
            self?.saveProgress()
        }
        historyViewModel.onChange = { [weak self] in
            self?.saveProgress()
        }
    }

    var character: Character {
        get {
            shopViewModel.character
        }
        set {
            shopViewModel.character = newValue
        }
    }

    var trophyCount: Int {
        shopViewModel.trophyBalance
    }

    var currentQuestionSet: QuestionSet {
        questionSetProgression[currentQuestionSetIndex]
    }

    func questionSet(withID id: UUID) -> QuestionSet? {
        questionSetProgression.first { questionSet in
            questionSet.id == id
        }
    }

    func updateCharacter(_ character: Character) {
        shopViewModel.updateCharacter(character)
        saveProgress()
    }

    func awardTrophy() {
        shopViewModel.awardTrophy()
        saveProgress()
    }

    func completeCurrentQuestionSet() {
        guard currentQuestionSet.isCompleted == false else {
            return
        }

        questionSetProgression[currentQuestionSetIndex].isCompleted = true
        let completedSetName = currentQuestionSet.setName
        if awardedQuestionSetNames.contains(completedSetName) == false {
            awardedQuestionSetNames.append(completedSetName)
            shopViewModel.awardTrophy()
        }

        if currentQuestionSetIndex < questionSetProgression.count - 1 {
            currentQuestionSetIndex += 1
        }
        saveProgress()
    }

    private func saveProgress() {
        var completedSetNames: [String] = []
        for questionSet in questionSetProgression {
            if questionSet.isCompleted {
                completedSetNames.append(questionSet.setName)
            }
        }

        let progress = AppProgress(
            character: shopViewModel.character,
            trophyCount: shopViewModel.trophyBalance,
            awardedQuestionSetNames: awardedQuestionSetNames,
            currentQuestionSetIndex: currentQuestionSetIndex,
            completedQuestionSetNames: completedSetNames,
            completedQuestions: historyViewModel.completedQuestions,
            incorrectQuestions: historyViewModel.incorrectQuestions,
            purchasedItemNames: shopViewModel.purchasedItemNames,
            equippedItemNames: shopViewModel.equippedItemNames
        )
        dataStore.saveProgress(progress)
    }

}

@Observable
@MainActor
final class HistoryViewModel {
    private(set) var completedQuestions: [CompletedQuestionRecord] = []
    private(set) var incorrectQuestions: [IncorrectQuestionRecord] = []
    var onChange: () -> Void = {}

    init(
        completedQuestions: [CompletedQuestionRecord] = [],
        incorrectQuestions: [IncorrectQuestionRecord] = []
    ) {
        self.completedQuestions = completedQuestions
        self.incorrectQuestions = incorrectQuestions
    }

    func recordCompletedQuestion(
        question: Question,
        selectedAnswer: String,
        questionSetName: String
    ) {
        let record = CompletedQuestionRecord(
            questionText: question.questionText,
            selectedAnswer: selectedAnswer,
            correctAnswer: question.correctAnswer,
            questionSetName: questionSetName,
            subject: question.subject,
            completedDate: Date()
        )

        completedQuestions.insert(record, at: 0)
        onChange()
    }

    func recordIncorrectQuestion(
        question: Question,
        incorrectAnswer: String,
        questionSetName: String
    ) {
        let record = IncorrectQuestionRecord(
            questionText: question.questionText,
            incorrectAnswer: incorrectAnswer,
            correctAnswer: question.correctAnswer,
            questionSetName: questionSetName,
            subject: question.subject,
            explanation: question.explanation,
            answeredDate: Date()
        )

        incorrectQuestions.insert(record, at: 0)
        onChange()
    }
}
