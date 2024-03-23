//
//  CustomQuizViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 20.03.24.
//

import Foundation

class CustomQuizViewModel {
    
    var countries: [NewCountry] = []
    var includeFlags: Bool = false
    var includeCapitals: Bool = false
    var includeCurrencies: Bool = false
    var enableTimer: Bool = false
    
    var noTypeTitle = "Can't create the Quiz!"
    var noTypeText = "Please select at least one type of quiz."
    
    func updatePreferences(flags: Bool, capitals: Bool, currencies: Bool, timer: Bool) {
        includeFlags = flags
        includeCapitals = capitals
        includeCurrencies = currencies
        enableTimer = timer
    }
    
    func getPreferences() -> QuizPreferences {
        QuizPreferences(includeFlags: includeFlags, includeCapitals: includeCapitals, includeCurrencies: includeCurrencies, enableTimer: enableTimer)
    }
    
    func checkIfTypeExists() -> Bool {
        if includeFlags == false && includeCapitals == false && includeCurrencies == false {
            return false
        } else {
            return true
        }
    }
}
