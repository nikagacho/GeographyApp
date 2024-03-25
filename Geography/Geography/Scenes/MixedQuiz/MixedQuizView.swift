//
//  MixedQuizView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 20.03.24.
//

import SwiftUI

struct MixedQuizView: View {
    @StateObject var viewModel: MixedQuizViewModel
    @EnvironmentObject var router: Router
    

    var body: some View {
        ZStack {
            Color(uiColor: .backgroundColor).edgesIgnoringSafeArea(.all)
            VStack {
                if viewModel.quizCompleted {
                    QuizCompletionView(score: viewModel.score, time: viewModel.secondsElapsed, restartAction: viewModel.restartQuiz, goBack: router.goBack, shouldUseTime: viewModel.preferences.enableTimer)
                        .onAppear {
                            viewModel.stopTimer()
                        }
                } else if let country = viewModel.selectedCountry {
                    VStack {
                        HStack {
                            TimerView(viewModel: viewModel, increment: viewModel.increment)
                            SoundButtonView(isSoundOn: $viewModel.isSoundOn)
                        }
                        QuestionView(question: viewModel.questionText, countryName: country.name, score: viewModel.score)
                        
                        switch viewModel.currentQuestionType {
                        case .flag:
                            FlagsQuizAnswersView(possibleAnswers: viewModel.possibleAnswers, answerSelected: viewModel.checkAnswer, selectedAnswer: $viewModel.selectedAnswer, correctAnswer: country.href.flag)
                        case .capital:
                            AnswersView(possibleAnswers: viewModel.possibleAnswers, answerSelected: viewModel.checkAnswer, selectedAnswer: $viewModel.selectedAnswer, correctAnswer: country.capital)
                        case .currency:
                            AnswersView(possibleAnswers: viewModel.possibleAnswers, answerSelected: viewModel.checkAnswer, selectedAnswer: $viewModel.selectedAnswer, correctAnswer: country.currency ?? "")
                        case .none:
                            Text("No question type selected")
                        }
                        Spacer()
                        QuizControlView(viewModel: viewModel, goBackAction: router.goBack, loadNextQuestion: viewModel.loadNextQuestion, selectedAnswer: $viewModel.selectedAnswer)
                    }
                } else {
                    Text("Error - Couldn't load the quiz")
                        .onAppear {
                            viewModel.loadFirstQuestion()
                            print("Possible Answers: \(viewModel.possibleAnswers)")
                            if viewModel.preferences.enableTimer {
                                viewModel.startTimer()
                            }
                        }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

