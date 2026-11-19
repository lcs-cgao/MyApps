//
//  AppProgress.swift
//  MyApps
//

import Foundation

struct AppProgress: Codable {
    var character: Character
    var trophyCount: Int
    var awardedQuestionSetNames: [String]
    var currentQuestionSetIndex: Int
    var completedQuestionSetNames: [String]
    var completedQuestions: [CompletedQuestionRecord]
    var incorrectQuestions: [IncorrectQuestionRecord]
    var purchasedItemNames: [String]
    var equippedItemNames: [String]

    static let empty = AppProgress(
        character: Character(),
        trophyCount: 0,
        awardedQuestionSetNames: [],
        currentQuestionSetIndex: 0,
        completedQuestionSetNames: [],
        completedQuestions: [],
        incorrectQuestions: [],
        purchasedItemNames: [],
        equippedItemNames: []
    )
}
