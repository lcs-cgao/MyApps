//
//  HistoryView.swift
//  MyApps
//

import SwiftUI

struct HistoryView: View {
    @Bindable var viewModel: HistoryViewModel

    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            completedQuestionsSection
            incorrectQuestionsSection
        }
        .navigationTitle("History")
    }

    private var completedQuestionsSection: some View {
        Section("Completed Questions") {
            if viewModel.completedQuestions.isEmpty {
                Text("No completed questions yet.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(viewModel.completedQuestions) { record in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(record.questionText)
                            .font(.headline)

                        Text("Your answer: \(record.selectedAnswer)")
                        Text("Correct answer: \(record.correctAnswer)")
                        Text("\(record.questionSetName) • \(record.subject.rawValue)")
                            .foregroundStyle(.secondary)
                        Text(record.completedDate.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }

    private var incorrectQuestionsSection: some View {
        Section("Incorrect Questions") {
            if viewModel.incorrectQuestions.isEmpty {
                Text("No incorrect questions yet.")
                    .foregroundStyle(.secondary)
            } else {
                ForEach(viewModel.incorrectQuestions) { record in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(record.questionText)
                            .font(.headline)

                        Text("Your answer: \(record.incorrectAnswer)")
                        Text("Correct answer: \(record.correctAnswer)")
                        Text("\(record.questionSetName) • \(record.subject.rawValue)")
                            .foregroundStyle(.secondary)
                        Text(record.explanation)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(record.answeredDate.formatted(date: .abbreviated, time: .shortened))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}
