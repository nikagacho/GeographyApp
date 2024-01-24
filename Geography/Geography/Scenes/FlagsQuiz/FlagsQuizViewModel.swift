//
//  FlagsQuizViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 23.01.24.
//

import Foundation

class FlagsQuizViewModel: ObservableObject {
    
    var countries: [NewCountry] = []
    var question = "Which one is the flag of "
    @Published var selectedCountry: NewCountry!
    @Published var possibleAnswers: [String] = []
    @Published var score = 0
    @Published var increment = 1
    @Published var quizCompleted = false
    @Published var selectedAnswer: String? = nil
    
    func returnPossibleAnswers(country: NewCountry) -> [String] {
        var flagAnswers: [String] = [country.href.flag]
        while flagAnswers.count < 4 {
            let randomCountry = countries.randomElement()
            let randomFlag = randomCountry?.href.flag ?? ""
            
            if randomCountry?.name != country.name && !flagAnswers.contains(randomFlag) {
                flagAnswers.append(randomFlag)
            }
        }
        return flagAnswers.shuffled()
    }
    
    func checkAnswer(flag: String) {
        selectedAnswer = flag
        guard let country = selectedCountry else { return }
        if flag == country.href.flag {
            score += 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
