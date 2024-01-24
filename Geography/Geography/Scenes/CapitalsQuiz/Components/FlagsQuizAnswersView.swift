//
//  FlagsQuizAnswersView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 24.01.24.
//

import SwiftUI

struct FlagsQuizAnswersView: View {
    let possibleAnswers: [String]
    var answerSelected: (String) -> Void
    @Binding var selectedAnswer: String?
    var correctAnswer: String
    
    var body: some View {
        ForEach(possibleAnswers, id: \.self) { flag in
            AsyncImage(url: URL(string: flag)) { image in
                image.resizable()
                    .frame(width: 100, height: 80)
                    .border(.black, width: 5)
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 80)
            }
            .onTapGesture {
                answerSelected(flag)
            }
        }
    }
    
    private func buttonColor(for flag: String) -> Color {
        guard let selected = selectedAnswer else {
            return .blue
        }
        if selected == flag {
            return selected == correctAnswer ? .green : .red
        } else if flag == correctAnswer {
            return selectedAnswer != nil ? .green : .blue
        } else {
            return .blue
        }
    }
    
    
    
}
