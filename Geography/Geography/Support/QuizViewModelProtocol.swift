//
//  QuizViewModelProtocol.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 28.01.24.
//

import Foundation

protocol QuizViewModelProtocol: ObservableObject {
    var question: String { get }
    var selectedCountry: NewCountry! { get set }
    var possibleAnswers: [String] { get }
    var score: Int { get set }
    var increment: Int { get set }
    var quizCompleted: Bool { get set }
    var selectedAnswer: String? { get set }
    var secondsElapsed: Int { get set }
    
    func returnPossibleAnswers(country: NewCountry) -> [String]
    func checkAnswer(answer: String)
    func loadNextQuestion()
    func loadFirstQuestion()
    func restartQuiz()
}
