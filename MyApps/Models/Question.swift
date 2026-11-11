//
//  Question.swift
//  MyApps
//

import Foundation

enum Subject: String, CaseIterable, Identifiable {
    case mathematics = "Mathematics"
    case science = "Science"
    case history = "History"
    case french = "French"

    var id: String {
        rawValue
    }
}

struct Question: Identifiable {
    let id: UUID = UUID()
    let questionText: String
    let answerOptions: [String]
    let correctAnswer: String
    let explanation: String
    let subject: Subject
}
