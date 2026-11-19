//
//  HomeViewModel.swift
//  MyApps
//

import Foundation
import Observation

@Observable
final class HomeViewModel {
    var character = Character()
    var trophyCount = 0
    let historyViewModel = HistoryViewModel()
    private(set) var currentQuestionSetIndex = 0
    private(set) var questionSetProgression = QuestionSet.questionSetProgression

    var currentQuestionSet: QuestionSet {
        questionSetProgression[currentQuestionSetIndex]
    }

    func questionSet(withID id: UUID) -> QuestionSet? {
        questionSetProgression.first { questionSet in
            questionSet.id == id
        }
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
        awardTrophy()

        if currentQuestionSetIndex < questionSetProgression.count - 1 {
            currentQuestionSetIndex += 1
        }
    }

}

@Observable
final class HistoryViewModel {
        private(set) var completedQuestions: [CompletedQuestionRecord] = []
        private(set) var incorrectQuestions: [IncorrectQuestionRecord] = []

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
        }
}
