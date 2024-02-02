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
    
    var layout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        LazyVGrid(columns: layout) {
            ForEach(possibleAnswers, id: \.self) { flag in
                AsyncImage(url: URL(string: flag)) { image in
                    image.resizable()
                        .frame(height: 120)
                        .border(borderColor(for: flag), width: 10)
                        .cornerRadius(8)
                        .padding()
                } placeholder: {
                    ProgressView()
                        .frame(height: 120)
                        .padding()
                }
                .onTapGesture {
                    if selectedAnswer == nil {
                        answerSelected(flag)
                    }
                }
            }
        }
    }
    
    private func borderColor(for flag: String) -> Color {
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
