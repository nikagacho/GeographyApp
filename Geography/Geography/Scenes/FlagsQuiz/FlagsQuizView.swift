//
//  FlagsQuizView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 23.01.24.
//

import SwiftUI

struct FlagsQuizView: View {
    
    @StateObject var viewModel: FlagsQuizViewModel
    
    var body: some View {
        if viewModel.quizCompleted {
            QuizCompletionView(score: viewModel.score, restartAction: viewModel.restartQuiz)
        } else if let country = viewModel.selectedCountry {
            QuestionView(question: viewModel.question, countryName: country.name, score: viewModel.score, increment: viewModel.increment)
            FlagsQuizAnswersView(possibleAnswers: viewModel.returnPossibleAnswers(country: country), answerSelected: viewModel.checkAnswer, selectedAnswer: $viewModel.selectedAnswer, correctAnswer: country.href.flag)
        }  else {
            Text("Loading QUIZ")
                .onAppear { viewModel.loadNewQuestion() }
        }
    }
}
