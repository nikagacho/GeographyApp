//
//  Extensions.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 17.01.24.
//

import SwiftUI
import UIKit

extension View {
     func formattedTime(seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(seconds)) ?? "0:00"
    }
}

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
