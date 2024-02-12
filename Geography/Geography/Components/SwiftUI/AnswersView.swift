//
//  AnswersView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 23.01.24.
//

import SwiftUI

struct AnswersView: View {
    //MARK: - Properties
    let possibleAnswers: [String]
    var answerSelected: (String) -> Void
    @Binding var selectedAnswer: String?
    var correctAnswer: String
    @State private var shakeIncorrect = false
    //MARK: - Body
    var body: some View {
        ForEach(possibleAnswers, id: \.self) { capital in
            Button(action: {
                handleTap(for: capital)
            }, label: {
                Text(capital)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(buttonColor(for: capital))
                    .foregroundColor(.white)
                    .font(.myFont(size: 24))
                    .cornerRadius(10)
                    .padding(.horizontal)
                .modifier(Shake(animatableData: CGFloat(shouldShake(capital: capital) ? 1 : 0)))             })
            .disabled(selectedAnswer != nil)
            .padding(.horizontal)
        }
    }
    //MARK: - Methods to update UI on correct/incorrect
    private func handleTap(for capital: String) {
        guard selectedAnswer == nil else { return }
        answerSelected(capital)
        if capital != correctAnswer {
            withAnimation(.default) {
                shakeIncorrect.toggle()
            }
        }
    }
    
    private func shouldShake(capital: String) -> Bool {
        shakeIncorrect && selectedAnswer == capital && capital != correctAnswer
    }
    
    private func buttonColor(for capital: String) -> Color {
        guard let selected = selectedAnswer else {
            return .blue
        }
        if selected == capital {
            return selected == correctAnswer ? .green : .red
        } else if capital == correctAnswer {
            return selectedAnswer != nil ? .green : .blue
        } else {
            return .blue
        }
    }
}
