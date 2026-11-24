//
//  History.swift
//  MyApps
//
//  Created by GaoZiHan on 2026-11-24.
//  This code was generated using GitHub Copilot: quiz history record structures.
//  The record fields and quiz tracking logic are my own.

import Foundation

struct CompletedQuestionRecord: Identifiable, Codable {
    var id = UUID()
    let questionText: String
    let selectedAnswer: String
    let correctAnswer: String
    let questionSetName: String
    let subject: Subject
    let completedDate: Date
}

struct IncorrectQuestionRecord: Identifiable, Codable {
    var id = UUID()
    let questionText: String
    let incorrectAnswer: String
    let correctAnswer: String
    let questionSetName: String
    let subject: Subject
    let explanation: String
    let answeredDate: Date
}
