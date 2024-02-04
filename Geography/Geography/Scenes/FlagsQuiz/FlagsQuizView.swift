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
        VStack {
            if viewModel.quizCompleted {
                QuizCompletionView(score: viewModel.score, time: viewModel.secondsElapsed, restartAction: viewModel.restartQuiz, goBack: flowNavigator.goBack)
                    .onAppear {
                        viewModel.stopTimer()
                    }
            } else if let country = viewModel.selectedCountry {
                HStack {
                    TimerView(viewModel: viewModel)
                    Spacer()
                    SoundButtonView(isSoundOn: $viewModel.isSoundOn)
                }
                QuestionView(question: viewModel.question, countryName: country.name, score: viewModel.score, increment: viewModel.increment)
                FlagsQuizAnswersView(possibleAnswers: viewModel.possibleAnswers, answerSelected: viewModel.checkAnswer, selectedAnswer: $viewModel.selectedAnswer, correctAnswer: country.href.flag)
                QuizControlView(viewModel: viewModel, goBackAction: flowNavigator.goBack, selectedAnswer: $viewModel.selectedAnswer)
            }  else {
                Text("Loading QUIZ")
                    .onAppear { 
                        viewModel.loadFirstQuestion()
                        viewModel.startTimer()
                    }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
