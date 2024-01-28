//
//  MainQuizViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 28.01.24.
//

import Foundation

class MainQuizViewModel: ObservableObject {
    var countries: [NewCountry] = []
    @Published var selectedCountry: NewCountry!
    @Published var score = 0
    @Published var increment = 1
    @Published var quizCompleted = false
    @Published var selectedAnswer: String? = nil
    var previousQuestions: [NewCountry] = []
    
    func loadNextQuestion() {
        var nextCountry: NewCountry?
        repeat {
            nextCountry = countries.randomElement()
        } while nextCountry != nil && previousQuestions.contains(where: { $0.name == nextCountry!.name })
        
        if let nextCountry = nextCountry {
            selectedCountry = nextCountry
            increment += 1
            selectedAnswer = nil
            previousQuestions.append(nextCountry)
        }
    }
    
    func loadFirstQuestion() {
        previousQuestions = []
        guard let randomCountry = countries.randomElement() else { return }
        selectedCountry = randomCountry
        previousQuestions.append(selectedCountry)
    }
    
    func restartQuiz() {
        increment = 1
        score = 0
        selectedAnswer = nil
        quizCompleted = false
        loadFirstQuestion()
    }
    
    func returnPossibleAnswers(country: NewCountry) -> [String] {
           fatalError("This method must be overridden")
       }

       func checkAnswer(answer: String) {
           fatalError("This method must be overridden")
       }
}
