//
//  QuizViewModelProtocol.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 28.01.24.
//

import Foundation

protocol QuizViewModelProtocol: AnyObject {
    //MARK: - Properties
    var countries: [NewCountry] { get set }
    var selectedCountry: NewCountry! { get set }
    var possibleAnswers: [String] { get set }
    var score: Int { get set }
    var increment: Int { get set }
    var quizCompleted: Bool { get set }
    var selectedAnswer: String? { get set }
    var secondsElapsed: Int { get set }
    var isSoundOn: Bool { get set }
    var previousQuestions: [NewCountry] { get set }
    var timer: Timer? { get set }
    //MARK: - Methods
    func returnPossibleAnswers(country: NewCountry) -> [String]
    func checkAnswer(answer: String)
    func loadNextQuestion()
    func loadFirstQuestion()
    func restartQuiz()
    func startTimer()
    func stopTimer()
}
//MARK: - Extension for reused methods
extension QuizViewModelProtocol where Self: ObservableObject {
    func loadNextQuestion() {
        var nextCountry: NewCountry?
        repeat {
            nextCountry = countries.randomElement()
        } while nextCountry != nil && previousQuestions.contains(where: { $0.name == nextCountry!.name })
        
        if let nextCountry = nextCountry {
            selectedCountry = nextCountry
            possibleAnswers = returnPossibleAnswers(country: selectedCountry)
            increment += 1
            selectedAnswer = nil
            previousQuestions.append(nextCountry)
        }
    }
    
    func loadFirstQuestion() {
        previousQuestions = []
        guard let randomCountry = countries.randomElement() else { return }
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



