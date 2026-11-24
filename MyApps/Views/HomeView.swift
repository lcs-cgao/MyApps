//
//  HomeView.swift
//  MyApps
//
//  Created by GaoZiHan on 2026-11-24.
//  This code was generated using GitHub Copilot: main adventure screen structure.
//  The app navigation and learning screen layout are my own.

import SwiftUI

struct HomeView: View {
    private enum Destination: Hashable {
        case quiz(UUID)
        case history
        case character
        case shop
    }

    @State private var viewModel: HomeViewModel
    @State private var isShowingSettings = false
    @State private var navigationPath: [Destination] = []

    init(initialCharacter: Character? = nil) {
        _viewModel = State(
            initialValue: HomeViewModel(initialCharacter: initialCharacter)
        )
    }

    var body: some View {
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack(spacing: 20) {
                    topArea
                    characterWelcomeArea
                    currentQuestionSetArea
                    bottomNavigationArea
                }
                .padding()
            }
            .background(Color.blue.opacity(0.12))
            .navigationTitle("Adventure Time")
            .alert("Settings", isPresented: $isShowingSettings) {
                Button("OK", role: .cancel) {
                }
            } message: {
                Text("Settings will be available soon!")
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .quiz(let questionSetID):
                    if let questionSet = viewModel.questionSet(withID: questionSetID) {
                        QuizView(
                            questionSet: questionSet,
                            alternativeQuestionSet: QuestionSet.retryQuestionSet(for: questionSet),
                            historyViewModel: viewModel.historyViewModel,
                            onCompleted: {
                                viewModel.completeCurrentQuestionSet()
                            },
                            onReturnToMainMenu: {
                                navigationPath.removeAll()
                            }
                        )
                    }
                case .history:
                    HistoryView(viewModel: viewModel.historyViewModel)
                case .character:
                    CharacterView(initialCharacter: viewModel.character) { selectedCharacter in
                        viewModel.updateCharacter(selectedCharacter)
                    }
                case .shop:
                    ShopView(homeViewModel: viewModel)
                }
            }
        }
    }

    private var topArea: some View {
        HStack {
            Button {
                isShowingSettings = true
            } label: {
                Label("Settings", systemImage: "gearshape.fill")
                    .labelStyle(.iconOnly)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding(12)
                    .background(Color.purple)
                    .clipShape(Circle())
            }
            .accessibilityLabel("Settings")

            Spacer()

            HStack(spacing: 12) {
                Label("\(viewModel.trophyCount)", systemImage: "trophy.fill")
                    .font(.headline)
                    .foregroundStyle(.orange)

                NavigationLink(value: Destination.history) {
                    Label("History", systemImage: "clock.arrow.circlepath")
                        .labelStyle(.iconOnly)
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(Color.teal)
                        .clipShape(Circle())
                }
                .accessibilityLabel("History")
            }
        }
    }

    private var characterWelcomeArea: some View {
        VStack(spacing: 12) {
            characterPreview

            Text("Welcome, adventurer!")
                .font(.title2.bold())
                .foregroundStyle(.purple)

            Text("Ready to learn something amazing today?")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.85))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private var characterPreview: some View {
        VStack(spacing: 8) {
            CharacterIllustration(
                character: viewModel.character,
                size: 120
            )

            Text(viewModel.character.accessories)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var currentQuestionSetArea: some View {
        VStack(spacing: 14) {
            Text(viewModel.currentQuestionSet.setName)
                .font(.headline)
                .foregroundStyle(.secondary)

            Text(viewModel.currentQuestionSet.subject.rawValue)
                .font(.largeTitle.bold())
                .foregroundStyle(.blue)

            Text("\(viewModel.currentQuestionSet.questions.count) questions")
                .font(.title3)

            Button {
                navigationPath.append(.quiz(viewModel.currentQuestionSet.id))
            } label: {
                Label("Start Adventure", systemImage: "star.fill")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .clipShape(Capsule())
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.yellow.opacity(0.35))
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }

    private var bottomNavigationArea: some View {
        HStack(spacing: 16) {
            NavigationLink(value: Destination.character) {
                bottomNavigationButton(
                    title: "Character",
                    systemImage: "person.fill",
                    color: .purple
                )
            }

            NavigationLink(value: Destination.shop) {
                bottomNavigationButton(
                    title: "Shop",
                    systemImage: "bag.fill",
                    color: .green
                )
            }
        }
    }

    private func bottomNavigationButton(
        title: String,
        systemImage: String,
        color: Color
    ) -> some View {
        Label(title, systemImage: systemImage)
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .clipShape(Capsule())
    }

}
