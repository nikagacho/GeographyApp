//
//  CapitalsQuizViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 19.01.24.
//

import Foundation

class CapitalsQuizViewModel {
    
    var countries: [Country] = [
        Country(name: Name(common: "Germany", official: "Germany"), capital: ["Berlin"], flag: ""),
        Country(name: Name(common: "France", official: "French Republic"), capital: ["Paris"], flag: ""),
        Country(name: Name(common: "Italy", official: "Italian Republic"), capital: ["Rome"], flag: ""),
        Country(name: Name(common: "Spain", official: "Kingdom of Spain"), capital: ["Madrid"], flag: ""),
        Country(name: Name(common: "United Kingdom", official: "United Kingdom of Great Britain"), capital: ["London"], flag: ""),
        Country(name: Name(common: "Japan", official: "Japan"), capital: ["Tokyo"], flag: ""),
        Country(name: Name(common: "Canada", official: "Canada"), capital: ["Ottawa"], flag: ""),
        Country(name: Name(common: "Australia", official: "Commonwealth of Australia"), capital: ["Canberra"], flag: ""),
        Country(name: Name(common: "Brazil", official: "Federative Republic of Brazil"), capital: ["Brasília"], flag: ""),
        Country(name: Name(common: "India", official: "Republic of India"), capital: ["New Delhi"], flag: "")
    ]
    var question = "What is the Capital City of "
    
    func randomCountry() -> Country {
        return countries.randomElement()!
    }
   
    
    func returnPossibleAnswers(country: Country) -> [String] {
        var answers: [String] = [country.capital.first!]
        while answers.count < 4 {
            let randomCountry = countries.randomElement()!
            let randomCapital = randomCountry.capital.first!

            if randomCountry.name.common != country.name.common && !answers.contains(randomCapital) {
                answers.append(randomCapital)
            }
        }
        return answers.shuffled()
    }
    func checkAnswer(country: Country, capital: String) -> Bool {
        if country.capital.first! == capital {
            return true
        } else {
            return false
        }
    }
    
}
