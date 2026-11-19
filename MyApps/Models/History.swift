//
//  History.swift
//  MyApps
//

import Foundation

struct CompletedQuestionRecord: Identifiable {
    let id = UUID()
    let questionText: String
    let selectedAnswer: String
    let correctAnswer: String
    let questionSetName: String
    let subject: Subject
    let completedDate: Date
}

struct IncorrectQuestionRecord: Identifiable {
    let id = UUID()
    let questionText: String
    let incorrectAnswer: String
    let correctAnswer: String
    let questionSetName: String
    let subject: Subject
    let explanation: String
    let answeredDate: Date
}
