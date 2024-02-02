//
//  CapitalsQuiz.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 19.01.24.
//

import SwiftUI

struct CapitalsQuiz: View {
    
    @StateObject var viewModel: CapitalsQuizViewModel
    @EnvironmentObject var flowNavigator: FlowNavigator
    let timerView = TimerView()
    
    var body: some View {
        VStack {
            if viewModel.quizCompleted {
                QuizCompletionView(score: viewModel.score, time: timerView.stopTimerAndRetrieveTime(), restartAction: viewModel.restartQuiz, goBack: flowNavigator.goBack)
            } else if let country = viewModel.selectedCountry {
                timerView
                QuestionView(question: viewModel.question,
                             countryName: country.name,
                             score: viewModel.score,
                             increment: viewModel.increment)
                
                AnswersView(possibleAnswers: viewModel.possibleAnswers,
                            answerSelected: viewModel.checkAnswer,
                            selectedAnswer: $viewModel.selectedAnswer, correctAnswer: country.capital)
                Spacer()
                QuizControlView(viewModel: viewModel, goBackAction: flowNavigator.goBack, selectedAnswer: $viewModel.selectedAnswer)
            } else {
                Text("Loading QUIZ")
                    .onAppear { viewModel.loadFirstQuestion() }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

