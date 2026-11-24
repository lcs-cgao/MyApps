//
//  Question.swift
//  MyApps
//
//  Created by GaoZiHan on 2026-11-24.
//  This code was generated using GitHub Copilot: quiz question and subject setup.
//  The question content and subject choices are my own.

import Foundation

enum Subject: String, CaseIterable, Identifiable, Codable {
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
