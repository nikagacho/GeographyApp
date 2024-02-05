//
//  FlagsQuizView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 23.01.24.
//

import SwiftUI

struct FlagsQuizView: View {
    
    @StateObject var viewModel: FlagsQuizViewModel
    @EnvironmentObject var flowNavigator: FlowNavigator
    
    var body: some View {
        ZStack {
            Color.init(uiColor: .systemGray5)
                .edgesIgnoringSafeArea(.all)
            VStack {
                if viewModel.quizCompleted {
                    QuizCompletionView(score: viewModel.score, time: viewModel.secondsElapsed, restartAction: viewModel.restartQuiz, goBack: flowNavigator.goBack)
                        .onAppear {
                            viewModel.stopTimer()
                        }
                } else if let country = viewModel.selectedCountry {
                    HStack {
                        TimerView(viewModel: viewModel, increment: viewModel.increment)
                        SoundButtonView(isSoundOn: $viewModel.isSoundOn)
                    }
                    QuestionView(question: viewModel.question, countryName: country.name, score: viewModel.score)
                    FlagsQuizAnswersView(possibleAnswers: viewModel.possibleAnswers, answerSelected: viewModel.checkAnswer, selectedAnswer: $viewModel.selectedAnswer, correctAnswer: country.href.flag)
                    QuizControlView(viewModel: viewModel, goBackAction: flowNavigator.goBack, selectedAnswer: $viewModel.selectedAnswer)
                }  else {
                    Text("Error - Couldn't load the quiz")
                        .onAppear {
                            viewModel.loadFirstQuestion()
                            viewModel.startTimer()
                        }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}
