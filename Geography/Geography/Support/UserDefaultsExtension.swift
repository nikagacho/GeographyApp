//
//  UserDefaultsExtension.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 09.02.24.
//

import Foundation
//MARK: - UserDefaults extension for storing/managing QuizResults
extension UserDefaults {
    func saveQuizResult(_ newResult: QuizResult) {
        let encoder = JSONEncoder()
        var results = loadQuizResults()
        results.append(newResult)
        if let encoded = try? encoder.encode(results) {
            UserDefaults.standard.set(encoded, forKey: "quizResults")
        }
    }

    func loadQuizResults() -> [QuizResult] {
        if let savedResults = UserDefaults.standard.object(forKey: "quizResults") as? Data {
            let decoder = JSONDecoder()
            if let loadedResults = try? decoder.decode([QuizResult].self, from: savedResults) {
                return loadedResults
            }
        }
        return []
    }
    
    func resetQuizResults() {
        UserDefaults.standard.set(nil, forKey: "quizResults")
    }
}
