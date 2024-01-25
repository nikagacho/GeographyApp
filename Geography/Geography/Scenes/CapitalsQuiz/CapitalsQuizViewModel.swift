//
//  CapitalsQuizViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 19.01.24.
//

import Foundation

class CapitalsQuizViewModel: ObservableObject {
    
    var countries: [NewCountry] = []
    var question = "What is the Capital City of "
    @Published var selectedCountry: NewCountry!
    @Published var possibleAnswers: [String] = []
    @Published var score = 0
    @Published var increment = 1
    @Published var quizCompleted = false
    @Published var selectedAnswer: String? = nil
    var previousQuestions: [NewCountry] = []
    
    func returnPossibleAnswers(country: NewCountry) -> [String] {
        var answers: [String] = [country.capital]
        while answers.count < 4 {
            let randomCountry = countries.randomElement()
            let randomCapital = randomCountry?.capital
            
            if randomCountry?.name != country.name && !answers.contains(randomCapital ?? "") {
                answers.append(randomCapital ?? "")
            }
        }
        return answers.shuffled()
    }
    
    func checkAnswer(capital: String) {
        selectedAnswer = capital
        guard let country = selectedCountry else { return }
        if capital == country.capital {
            score += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.increment += 1
            if self.increment > 10 {
                self.quizCompleted = true
            } else {
                self.loadNewQuestion()
            }
            self.selectedAnswer = nil
        }
    }
    
    func restartQuiz() {
        increment = 1
        score = 0
        quizCompleted = false
        loadNewQuestion()
    }
    
    func loadNewQuestion() {
        guard let randomCountry = countries.randomElement() else { return }
        selectedCountry = randomCountry
        possibleAnswers = returnPossibleAnswers(country: selectedCountry)
    }
    
}
