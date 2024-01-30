//
//  QuizControlView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 28.01.24.
//

import SwiftUI

struct QuizControlView<ViewModel: QuizViewModelProtocol & ObservableObject>: View {
    @ObservedObject var viewModel: ViewModel
    var goBackAction: () -> Void
    @Binding var selectedAnswer: String?

    var body: some View {
        HStack {
            Button("Abort Quiz") {
                goBackAction()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)

            if viewModel.increment < 10 {
                Button("Next") {
                    viewModel.loadNextQuestion()
                }
                .disabled(selectedAnswer == nil)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            } else {
                Button("End Quiz") {
                    viewModel.quizCompleted = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
    }
}

