//
//  AnswersView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 23.01.24.
//

import SwiftUI

struct AnswersView: View {
    let possibleAnswers: [String]
    var answerSelected: (String) -> Void
    @Binding var selectedAnswer: String?
    var correctAnswer: String
    
    var body: some View {
        ForEach(possibleAnswers, id: \.self) { capital in
            Button(action: { answerSelected(capital) }, label: {
                Text(capital)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(buttonColor(for: capital))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            })
            .disabled(selectedAnswer != nil)
            .padding(.horizontal)
        }
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
