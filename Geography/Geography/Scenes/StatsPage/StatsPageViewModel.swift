//
//  StatsPageViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 03.02.24.
//

import Foundation

final class StatsPageViewModel {
    //MARK: - Properties
    var quizResults: [QuizResult] = []
    var topThreeResults: [QuizResult] = []
    let alertMessage = "You're about to reset your statistics, are you sure? This can't be changed back"
    //MARK: - init
    init() {
        loadQuizResults()
        returnTopThree(for: quizResults)
        print(topThreeResults)
    }
    //MARK: - Methods
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
        return "Score: \(result.score) - Time: \(result.time) - \(result.date.formattedAsMediumDate())"
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

