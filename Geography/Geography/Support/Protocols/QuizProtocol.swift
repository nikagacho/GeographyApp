//
//  QuizProtocol.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 28.01.24.
//

import Foundation

protocol QuizProtocol: AnyObject {
    var preferences: QuizPreferences { get set }
    var countries: [NewCountry] { get set }
    var selectedCountry: NewCountry! { get set }
    var possibleAnswers: [String] { get set }
    var score: Int { get set }
    var increment: Int { get set }
    var quizCompleted: Bool { get set }
    var selectedAnswer: String? { get set }
    var secondsElapsed: Int { get set }
    var isSoundOn: Bool { get set }
    var currentQuestionType: QuestionType? { get set }
    var previousQuestions: [NewCountry] { get set }
    var timer: Timer? { get set }
    
    func generateCapitalAnswers(for country: NewCountry) -> [String]
    func generateFlagAnswers(for country: NewCountry) -> [String]
    func generateCurrencyAnswers(for country: NewCountry) -> [String]
    func returnPossibleAnswers(country: NewCountry) -> [String]
    func checkAnswer(answer: String)
    func loadNextQuestion()
    func selectRandomQuestionType()
    func stopTimer()
    func startTimer()
    func restartQuiz()
    func loadFirstQuestion()
}

extension QuizProtocol where Self: ObservableObject {
    func generateCapitalAnswers(for country: NewCountry) -> [String] {
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
    
    func generateFlagAnswers(for country: NewCountry) -> [String] {
        var answers: [String] = [country.href.flag]
        while answers.count < 4 {
            if let randomCountry = countries.randomElement(), randomCountry.name != country.name, !answers.contains(randomCountry.href.flag) {
                answers.append(randomCountry.href.flag)
            }
        }
        return answers.shuffled()
    }
    
    func generateCurrencyAnswers(for country: NewCountry) -> [String] {
        var answers: [String] = [country.currency ?? ""]
        while answers.count < 4 {
            let randomCountry = countries.randomElement()
            let randomCurrency = randomCountry?.currency
            if randomCountry?.name != country.name && !answers.contains(randomCurrency ?? "") {
                answers.append(randomCurrency ?? "")
            }
        }
        return answers.shuffled()
    }
    
    
    func returnPossibleAnswers(country: NewCountry) -> [String] {
        switch currentQuestionType {
        case .capital:
            return generateCapitalAnswers(for: country)
        case .flag:
            return generateFlagAnswers(for: country)
        case .currency:
            return generateCurrencyAnswers(for: country)
        case .none:
            return []
        }
    }
    
    func loadNextQuestion() {
        selectRandomQuestionType()
        
        var nextCountry: NewCountry?
        repeat {
            nextCountry = countries.randomElement()
        } while nextCountry != nil && (previousQuestions.contains { $0.name == nextCountry!.name } || nextCountry!.name == selectedCountry.name)
        
        if let nextCountry = nextCountry {
            selectedCountry = nextCountry
            possibleAnswers = returnPossibleAnswers(country: selectedCountry)
            increment += 1
            selectedAnswer = nil
            previousQuestions.append(nextCountry)
        }
        
    }
    
    func selectRandomQuestionType() {
        var types = [QuestionType]()
        if preferences.includeFlags { types.append(.flag) }
        if preferences.includeCapitals { types.append(.capital) }
        if preferences.includeCurrencies { types.append(.currency) }
        
        if let randomType = types.randomElement() {
            currentQuestionType = randomType
        }
    }
    
    func loadFirstQuestion() {
        previousQuestions = []
        guard let randomCountry = countries.randomElement() else {
            return
        }
        print("loaded first question")
        selectedCountry = randomCountry
        possibleAnswers = returnPossibleAnswers(country: selectedCountry)
        previousQuestions.append(selectedCountry)
    }
    
    func restartQuiz() {
        increment = 1
        score = 0
        selectedAnswer = nil
        quizCompleted = false
        loadFirstQuestion()
        secondsElapsed = 0
        startTimer()
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.secondsElapsed += 1
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}




