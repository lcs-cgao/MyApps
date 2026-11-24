//
//  QuizViewModel.swift
//  MyApps
//
//  Created by GaoZiHan on 2026-11-24.
//  This code was generated using GitHub Copilot: quiz answer and completion logic.
//  The quiz rules and feedback behavior are my own.

import Observation

@Observable
@MainActor
final class QuizViewModel {
    private(set) var questionSet: QuestionSet
    let alternativeQuestionSet: QuestionSet?
    let historyViewModel: HistoryViewModel
    private(set) var currentQuestionIndex = 0
    private(set) var selectedAnswer: String?
    private(set) var isAnswerCorrect = false
    private(set) var hasAnsweredCurrentQuestion = false
    private(set) var feedbackMessage = ""
    private(set) var incorrectlyAnsweredQuestions: [Question] = []
    private(set) var isQuizComplete = false

    init(
        questionSet: QuestionSet,
        alternativeQuestionSet: QuestionSet? = nil,
        historyViewModel: HistoryViewModel
    ) {
        self.questionSet = questionSet
        self.alternativeQuestionSet = alternativeQuestionSet
        self.historyViewModel = historyViewModel
    }

    var currentQuestion: Question {
        questionSet.questions[currentQuestionIndex]
    }

    var questionNumber: Int {
        currentQuestionIndex + 1
    }

    var progressValue: Double {
        Double(questionNumber) / Double(questionSet.questions.count)
    }

    var correctAnswer: String {
        currentQuestion.correctAnswer
    }

    var explanation: String {
        currentQuestion.explanation
    }

    func submitAnswer(_ answer: String) {
        guard hasAnsweredCurrentQuestion == false else {
            return
        }

        selectedAnswer = answer
        hasAnsweredCurrentQuestion = true

        if answer == currentQuestion.correctAnswer {
            isAnswerCorrect = true
            feedbackMessage = "Correct! Great job!"
            historyViewModel.recordCompletedQuestion(
                question: currentQuestion,
                selectedAnswer: answer,
                questionSetName: questionSet.setName
            )

            if currentQuestionIndex == questionSet.questions.count - 1 {
                isQuizComplete = true
            }
        } else {
            isAnswerCorrect = false
            feedbackMessage = "Not quite. Let’s learn from this one!"
            incorrectlyAnsweredQuestions.append(currentQuestion)
            historyViewModel.recordIncorrectQuestion(
                question: currentQuestion,
                incorrectAnswer: answer,
                questionSetName: questionSet.setName
            )
        }
    }

    func moveToNextQuestion() {
        guard hasAnsweredCurrentQuestion,
              isAnswerCorrect,
              isQuizComplete == false else {
            return
        }

        currentQuestionIndex += 1
        clearAnswerState()
    }

    func resetQuizProgress() {
        if let alternativeQuestionSet {
            questionSet = alternativeQuestionSet
        }
        currentQuestionIndex = 0
        isQuizComplete = false
        clearAnswerState()
    }

    private func clearAnswerState() {
        selectedAnswer = nil
        isAnswerCorrect = false
        hasAnsweredCurrentQuestion = false
        feedbackMessage = ""
    }
}
