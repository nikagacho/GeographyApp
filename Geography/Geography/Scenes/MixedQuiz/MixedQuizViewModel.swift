//
//  MixedQuizViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 20.03.24.
//

import Foundation
import AVFoundation

class MixedQuizViewModel: ObservableObject, QuizProtocol, AudioPlayerProtocol {
        
    var preferences: QuizPreferences
    @Published var countries: [NewCountry] = []
    @Published var selectedCountry: NewCountry!
    @Published var possibleAnswers: [String] = []
    @Published var score = 0
    @Published var increment = 1
    @Published var quizCompleted = false
    @Published var selectedAnswer: String? = nil
    @Published var secondsElapsed: Int = 0
    @Published var isSoundOn: Bool = true
    var previousQuestions: [NewCountry] = []
    var timer: Timer?
    var audioPlayer: AVAudioPlayer?
    
    @Published var currentQuestionType: QuestionType?
    
    var questionText: String {
        guard selectedCountry != nil else {
            return "Loading question..."
        }
            switch currentQuestionType {
            case .flag:
                return "What is the flag of "
            case .capital:
                return "What is the capital of "
            case .currency:
                return "What is the currency of "
            case .none:
                return "Loading question..."
            }
        }
    
    init(preferences: QuizPreferences, countries: [NewCountry]) {
        self.preferences = preferences
        self.countries = countries
        selectRandomQuestionType()
    }
    
    func checkAnswer(answer: String) {
        guard let country = selectedCountry else { return }
        selectedAnswer = answer
        switch currentQuestionType {
        case .capital:
            if answer == country.capital {
                score += 1
                playSound(soundFileName: "correct")
            } else {
                playSound(soundFileName: "wrong")
            }
        case .flag:
            if answer == country.href.flag {
                score += 1
                playSound(soundFileName: "correct")
            } else {
                playSound(soundFileName: "wrong")
            }
        case .currency:
            if answer == country.currency {
                score += 1
                playSound(soundFileName: "correct")
            } else {
                playSound(soundFileName: "wrong")
            }
        case .none:
            break
        }
    }
   
}
