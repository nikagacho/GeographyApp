//
//  CapitalsQuiz.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 19.01.24.
//

import SwiftUI

struct CapitalsQuiz: View {
    //MARK: - Properties
    @StateObject var viewModel: CapitalsQuizViewModel
    @EnvironmentObject var router : Router
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.init(uiColor: .systemGray5)
                .edgesIgnoringSafeArea(.all)
            VStack {
                if viewModel.quizCompleted {
                    QuizCompletionView(score: viewModel.score, time: viewModel.secondsElapsed, restartAction: viewModel.restartQuiz, goBack: router.goBack)
                        .onAppear {
                            viewModel.stopTimer()
                        }
                } else if let country = viewModel.selectedCountry {
                    HStack {
                        TimerView(viewModel: viewModel, increment: viewModel.increment)
                        SoundButtonView(isSoundOn: $viewModel.isSoundOn)
                    }
                    QuestionView(question: viewModel.question,
                                 countryName: country.name,
                                 score: viewModel.score)
                    
                    AnswersView(possibleAnswers: viewModel.possibleAnswers,
                                answerSelected: viewModel.checkAnswer,
                                selectedAnswer: $viewModel.selectedAnswer, correctAnswer: country.capital)
                    Spacer()
                    QuizControlView(viewModel: viewModel, goBackAction: router.goBack, selectedAnswer: $viewModel.selectedAnswer)
                } else {
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

