//
//  CharacterIllustration.swift
//  MyApps
//
//  Created by GaoZiHan on 2026-11-24.
//  This code was generated using GitHub Copilot: SwiftUI character illustration.
//  The character appearance and design choices are my own.

import SwiftUI

struct CharacterIllustration: View {
    let character: Character
    let size: CGFloat

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                face
                    .overlay(alignment: .top) {
                        hair
                    }
                    .overlay(alignment: .leading) {
                        if character.accessories == "Glasses"
                            || character.accessories == "Round Glasses"
                            || character.accessories == "Sun Glasses" {
                            glasses
                        }
                    }

                bodySection
            }

            hat
                .offset(y: -size * 0.34)

            accessory
        }
        .frame(width: size, height: size)
    }

    private var face: some View {
        ZStack {
            Circle()
                .fill(skinToneColor)

            HStack(spacing: size * 0.16) {
                Capsule()
                    .fill(eyeColor)
                    .frame(width: size * 0.055, height: size * 0.035)

                Capsule()
                    .fill(eyeColor)
                    .frame(width: size * 0.055, height: size * 0.035)
            }
            .offset(y: size * 0.03)

            VStack(spacing: size * 0.06) {
                RoundedRectangle(cornerRadius: size * 0.02)
                    .fill(.primary.opacity(0.45))
                    .frame(width: size * 0.08, height: size * 0.018)
            }
            .offset(y: size * 0.15)
        }
        .frame(width: size * 0.58, height: size * 0.58)
    }

    @ViewBuilder
    private var hair: some View {
        if character.hairstyle == "Ponytail" {
            ZStack(alignment: .trailing) {
                Ellipse()
                    .fill(hairColor)
                    .frame(width: size * 0.58, height: size * 0.16)
                    .offset(y: -size * 0.22)

                Capsule()
                    .fill(hairColor)
                    .frame(width: size * 0.16, height: size * 0.28)
                    .rotationEffect(.degrees(-18))
                    .offset(x: size * 0.38, y: size * 0.06)
            }
        } else if character.hairstyle == "Curly" {
            ZStack {
                ForEach(0..<7, id: \.self) { index in
                    Circle()
                        .fill(hairColor)
                        .frame(width: size * 0.16, height: size * 0.16)
                        .offset(
                            x: CGFloat(index - 3) * size * 0.09,
                            y: -size * 0.26
                        )
                }
            }
        } else {
            Ellipse()
                .fill(hairColor)
                .frame(width: size * 0.58, height: size * 0.16)
                .offset(y: -size * 0.22)
        }
    }

    private var bodySection: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.12)
                .fill(shirtColor)
                .frame(width: size * 0.62, height: size * 0.30)

            Circle()
                .fill(skinToneColor)
                .frame(width: size * 0.24, height: size * 0.24)
                .offset(x: -size * 0.42)

            Circle()
                .fill(skinToneColor)
                .frame(width: size * 0.24, height: size * 0.24)
                .offset(x: size * 0.42)
        }
        .offset(y: -size * 0.02)
    }

    private var glasses: some View {
        HStack(spacing: size * 0.08) {
            Circle()
                .stroke(.primary, lineWidth: max(1, size * 0.018))
                .frame(width: size * 0.17, height: size * 0.17)
            Circle()
                .stroke(.primary, lineWidth: max(1, size * 0.018))
                .frame(width: size * 0.17, height: size * 0.17)
        }
        .offset(x: size * 0.12, y: size * 0.01)
    }

    @ViewBuilder
    private var hat: some View {
        if character.accessories == "Hat"
            || character.accessories == "Blue Hat"
            || character.accessories == "Crown" {
            ZStack(alignment: .bottom) {
                if character.accessories == "Crown" {
                    CrownShape()
                        .fill(.yellow)
                        .frame(width: size * 0.42, height: size * 0.20)
                } else {
                    RoundedRectangle(cornerRadius: size * 0.04)
                        .fill(.blue)
                        .frame(width: size * 0.46, height: size * 0.16)
                }
            }
        }
    }

    @ViewBuilder
    private var accessory: some View {
        if character.accessories == "Backpack" {
            RoundedRectangle(cornerRadius: size * 0.06)
                .fill(.brown)
                .frame(width: size * 0.22, height: size * 0.28)
                .offset(x: size * 0.38, y: size * 0.18)
        } else if character.accessories == "Necklace" {
            Circle()
                .stroke(.yellow, lineWidth: max(2, size * 0.018))
                .frame(width: size * 0.24, height: size * 0.24)
                .offset(y: size * 0.18)
        }
    }

    private var skinToneColor: Color {
        switch character.skinTone {
        case "Light":
            return Color(red: 1.0, green: 0.82, blue: 0.68)
        case "Dark":
            return Color(red: 0.38, green: 0.20, blue: 0.10)
        default:
            return Color(red: 0.72, green: 0.45, blue: 0.28)
        }
    }

    private var eyeColor: Color {
        switch character.eyeColor {
        case "Blue":
            return .blue
        case "Green":
            return .green
        default:
            return .brown
        }
    }

    private var hairColor: Color {
        switch character.hairColor {
        case "Black":
            return .black
        case "Blonde":
            return .yellow
        default:
            return .brown
        }
    }

    private var shirtColor: Color {
        if character.outfit.contains("Sporty") {
            return .green
        }
        if character.outfit.contains("Fancy") {
            return .purple
        }
        if character.outfit.contains("Red Shirt") {
            return .red
        }
        return .blue
    }
}

private struct CrownShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.25, y: rect.midY * 0.55))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - rect.width * 0.25, y: rect.midY * 0.55))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
