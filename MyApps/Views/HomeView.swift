//
//  HomeView.swift
//  MyApps
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @State private var isShowingSettings = false

    var body: some View {
        NavigationStack {
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

                NavigationLink(destination: HistoryView()) {
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
            ZStack {
                Circle()
                    .fill(skinToneColor)
                    .frame(width: 120, height: 120)

                VStack(spacing: 8) {
                    Text(hairSymbol)
                        .font(.system(size: 34))

                    HStack(spacing: 20) {
                        Circle()
                            .fill(eyeColor)
                            .frame(width: 12, height: 12)
                        Circle()
                            .fill(eyeColor)
                            .frame(width: 12, height: 12)
                    }
                }
            }

            Text(outfitSymbol)
                .font(.system(size: 38))

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
                // The quiz system will be connected in a later step.
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
            NavigationLink {
                CharacterView { selectedCharacter in
                    viewModel.updateCharacter(selectedCharacter)
                }
            } label: {
                bottomNavigationButton(
                    title: "Character",
                    systemImage: "person.fill",
                    color: .purple
                )
            }

            NavigationLink(destination: ShopView()) {
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

    private var skinToneColor: Color {
        switch viewModel.character.skinTone {
        case "Light":
            return Color(red: 1.0, green: 0.82, blue: 0.68)
        case "Dark":
            return Color(red: 0.38, green: 0.20, blue: 0.10)
        default:
            return Color(red: 0.72, green: 0.45, blue: 0.28)
        }
    }

    private var eyeColor: Color {
        switch viewModel.character.eyeColor {
        case "Blue":
            return .blue
        case "Green":
            return .green
        default:
            return .brown
        }
    }

    private var hairSymbol: String {
        switch viewModel.character.hairstyle {
        case "Curly":
            return "〰️"
        case "Ponytail":
            return "🎀"
        default:
            return "🧢"
        }
    }

    private var outfitSymbol: String {
        switch viewModel.character.outfit {
        case "Sporty":
            return "⚽️"
        case "Fancy":
            return "👗"
        default:
            return "👕"
        }
    }
}
