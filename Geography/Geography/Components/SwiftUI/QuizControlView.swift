//
//  QuizControlView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 28.01.24.
//

import SwiftUI

struct QuizControlView<ViewModel: QuizViewModelProtocol & ObservableObject>: View {
    //MARK: - Properties
    @ObservedObject var viewModel: ViewModel
    var goBackAction: () -> Void
    @Binding var selectedAnswer: String?
    @State var isAlertShown = false
    //MARK: - Body
    var body: some View {
        HStack {
            Button("Exit") {
                isAlertShown = true
            }
            .alert(isPresented: $isAlertShown) {
                Alert(
                    title: Text("Exit Quiz"),
                    message: Text("Are you sure you want to Exit the quiz? Your progress will not be saved."),
                    primaryButton: .destructive(Text("Exit")) {
                        goBackAction()
                    },
                    secondaryButton: .cancel()
                )
            }
            .buttonStyle(backgroundColor: Color.red, opacity: 1)
            let buttonOpacity = selectedAnswer == nil ? 0.2 : 1
            if viewModel.increment < 10 {
                Button("Next") {
                    viewModel.loadNextQuestion()
                }
                .buttonStyle(backgroundColor: Color.orange, opacity: buttonOpacity)
                .disabled(selectedAnswer == nil)
            } else {
                Button("End Quiz") {
                    viewModel.quizCompleted = true
                }
                .buttonStyle(backgroundColor: Color.orange, opacity: buttonOpacity)
                .disabled(selectedAnswer == nil)
            }
        }
    }
}



