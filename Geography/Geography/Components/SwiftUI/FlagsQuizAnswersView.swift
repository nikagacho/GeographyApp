//
//  FlagsQuizAnswersView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 24.01.24.
//

import SwiftUI

struct FlagsQuizAnswersView: View {
    //MARK: - Properties
    let possibleAnswers: [String]
    var answerSelected: (String) -> Void
    @Binding var selectedAnswer: String?
    var correctAnswer: String
    @State private var shakeIncorrect = false
    //MARK: - Body
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
            ForEach(possibleAnswers, id: \.self) { flag in
                AsyncImage(url: URL(string: flag)) { image in
                    image.resizable()
                        .frame(height: 120)
                        .border(self.borderColor(for: flag), width: 6)
                        .cornerRadius(8)
                        .padding()
                        .modifier(Shake(animatableData: CGFloat(shouldShake(flag: flag) ? 1 : 0)))
                } placeholder: {
                    ProgressView()
                        .frame(height: 120)
                        .padding()
                }
                .onTapGesture { handleTap(for: flag) }
            }
        }
    }
    //MARK: - Methods to handle correct/incorrect
    private func borderColor(for flag: String) -> Color {
        if let selected = selectedAnswer, selected == flag {
            return selected == correctAnswer ? .green : .red
        } else if flag == correctAnswer && selectedAnswer != nil {
            return .green
        }
        return .blue
    }

    private func shouldShake(flag: String) -> Bool {
        shakeIncorrect && selectedAnswer == flag && flag != correctAnswer
    }
    
    private func handleTap(for flag: String) {
        guard selectedAnswer == nil else { return }
        answerSelected(flag)
        if flag != correctAnswer {
            withAnimation(.default) {
                shakeIncorrect.toggle()
            }
        }
    }
}

