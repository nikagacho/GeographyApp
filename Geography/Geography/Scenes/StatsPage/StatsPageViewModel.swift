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

    init() {
        loadQuizResults()
        returnTopThree(for: quizResults)
        print(topThreeResults)
    }
    
    private func loadQuizResults() {
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
        return "Score: \(result.score) - Time: \(result.time) - Date: \(dateFormatter.string(from: result.date))"
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
}

