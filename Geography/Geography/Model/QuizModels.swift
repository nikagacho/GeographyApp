//
//  QuizModels.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 20.03.24.
//

import Foundation

struct QuizPreferences {
    var includeFlags: Bool
    var includeCapitals: Bool
    var includeCurrencies: Bool
    var enableTimer: Bool
}

enum QuestionType {
    case flag
    case capital
    case currency
}

