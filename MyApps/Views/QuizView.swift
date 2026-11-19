//
//  QuizView.swift
//  MyApps
//

import SwiftUI

struct QuizView: View {
    @State private var viewModel: QuizViewModel
    @State private var shouldShowCompletion = false

    let onCompleted: () -> Void
    let onReturnToMainMenu: () -> Void

    init(
        questionSet: QuestionSet,
        alternativeQuestionSet: QuestionSet? = nil,
        historyViewModel: HistoryViewModel,
        onCompleted: @escaping () -> Void = {},
        onReturnToMainMenu: @escaping () -> Void = {}
    ) {
        _viewModel = State(
            initialValue: QuizViewModel(
                questionSet: questionSet,
                alternativeQuestionSet: alternativeQuestionSet,
                historyViewModel: historyViewModel
            )
        )
        self.onCompleted = onCompleted
        self.onReturnToMainMenu = onReturnToMainMenu
    }

    var body: some View {
        VStack(spacing: 20) {
            if viewModel.isQuizComplete {
                Text("All answers are correct!")
                    .font(.title2.bold())
                    .foregroundStyle(.green)
            } else {
                quizHeader
                questionCard
                answerOptions
                feedbackArea
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .navigationTitle(viewModel.questionSet.setName)
        .navigationDestination(isPresented: $shouldShowCompletion) {
            CompletionView(
                questionSetName: viewModel.questionSet.setName,
                subjectName: viewModel.questionSet.subject.rawValue,
                onReturnToMainMenu: onReturnToMainMenu
            )
        }
        .onChange(of: viewModel.isQuizComplete) {
            if viewModel.isQuizComplete {
                onCompleted()
                shouldShowCompletion = true
            }
        }
    }

    private var quizHeader: some View {
        VStack(spacing: 10) {
            Text("Question \(viewModel.questionNumber) / \(viewModel.questionSet.questions.count)")
                .font(.headline)

            ProgressView(value: viewModel.progressValue)
                .tint(.orange)
        }
    }

    private var questionCard: some View {
        Text(viewModel.currentQuestion.questionText)
            .font(.title2.bold())
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private var answerOptions: some View {
        VStack(spacing: 12) {
            ForEach(viewModel.currentQuestion.answerOptions, id: \.self) { answer in
                Button {
                    viewModel.submitAnswer(answer)
                } label: {
                    Text(answer)
                        .font(.body.weight(.medium))
                        .foregroundStyle(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(answerBackground(for: answer))
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .buttonStyle(.plain)
                .disabled(viewModel.hasAnsweredCurrentQuestion)
            }
        }
    }

    @ViewBuilder
    private var feedbackArea: some View {
        if viewModel.hasAnsweredCurrentQuestion {
            VStack(spacing: 12) {
                Text(viewModel.feedbackMessage)
                    .font(.headline)
                    .foregroundStyle(viewModel.isAnswerCorrect ? .green : .red)

                if viewModel.isAnswerCorrect {
                    Button("Next Question") {
                        viewModel.moveToNextQuestion()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                } else {
                    VStack(spacing: 6) {
                        Text("Correct answer: \(viewModel.correctAnswer)")
                            .font(.subheadline.bold())

                        Text(viewModel.explanation)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                    }

                    Button("Try Different Questions") {
                        viewModel.resetQuizProgress()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
    }

    private func answerBackground(for answer: String) -> Color {
        guard viewModel.hasAnsweredCurrentQuestion else {
            return Color.white
        }

        if answer == viewModel.correctAnswer {
            return Color.green.opacity(0.3)
        }

        if answer == viewModel.selectedAnswer {
            return Color.red.opacity(0.3)
        }

        return Color.white.opacity(0.6)
    }
}
