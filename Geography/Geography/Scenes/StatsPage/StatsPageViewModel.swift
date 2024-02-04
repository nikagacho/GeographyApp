//
//  StatsPageViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 03.02.24.
//

import Foundation

class StatsPageViewModel {
    var quizResults: [QuizResult] = []
    var topThreeResults: [QuizResult] = []
    var alertMessage = "You're about to reset your statistics, are you sure? This can't be changed back"

    init() {
        loadQuizResults()
        returnTopThree(for: quizResults)
        print(topThreeResults)
    }
    
    func loadQuizResults() {
        self.quizResults = UserDefaults.standard.loadQuizResults()
    }
    
    func saveNewQuizResult(_ result: QuizResult) {
        UserDefaults.standard.saveQuizResult(result)
        loadQuizResults()
    }
    
    var numberOfResults: Int {
        return quizResults.count
    }
    
    func result(at index: Int) -> QuizResult {
        return quizResults[index]
    }
    
    func formattedResult(for index: Int) -> String {
        let result = quizResults[index]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return "Score: \(result.score) - Time: \(result.time) - \(dateFormatter.string(from: result.date))"
    }
    
    func returnTopThree(for quizResults: [QuizResult]) {
        let sortedResults = quizResults.sorted { (quizResultOne, quizResultTwo) -> Bool in
            if quizResultOne.score != quizResultTwo.score {
                return quizResultOne.score > quizResultTwo.score
            } else {
                return quizResultOne.time < quizResultTwo.time
            }
        }
        topThreeResults = Array(sortedResults.prefix(3))
    }
    
    func returnTotalScore() -> Int {
        quizResults.reduce(0) { $0 + $1.score }
    }
    
    func returnTotalQuestions() -> Int {
        quizResults.count * 10
    }
    
    func resetAction() {
        UserDefaults.standard.resetQuizResults()
    }
}

