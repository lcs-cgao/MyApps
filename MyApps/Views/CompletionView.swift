//
//  CompletionView.swift
//  MyApps
//
//  Created by GaoZiHan on 2026-11-24.
//  This code was generated using GitHub Copilot: quiz completion screen.
//  The completion message and trophy presentation are my own.

import SwiftUI

struct CompletionView: View {
    let questionSetName: String
    let subjectName: String
    let onReturnToMainMenu: () -> Void

    @State private var trophyScale = 0.5
    @State private var trophyRotation = Angle.degrees(-12)

    init(
        questionSetName: String,
        subjectName: String,
        onReturnToMainMenu: @escaping () -> Void = {}
    ) {
        self.questionSetName = questionSetName
        self.subjectName = subjectName
        self.onReturnToMainMenu = onReturnToMainMenu
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("Congratulations!")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)

            Text("You completed this question set!")
                .font(.title2)
                .multilineTextAlignment(.center)

            VStack(spacing: 8) {
                Text(subjectName)
                    .font(.headline)
                    .foregroundStyle(.secondary)

                Text(questionSetName)
                    .font(.title2.bold())
            }

            Image(systemName: "trophy.fill")
                .font(.system(size: 90))
                .foregroundStyle(.yellow)
                .shadow(color: .orange.opacity(0.5), radius: 8)
                .scaleEffect(trophyScale)
                .rotationEffect(trophyRotation)
                .accessibilityLabel("Trophy reward")

            Button("Return to Main Menu") {
                onReturnToMainMenu()
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow.opacity(0.15))
        .navigationTitle("Completed")
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.65)) {
                trophyScale = 1
                trophyRotation = .zero
            }
        }
    }
}
