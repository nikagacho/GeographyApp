//
//  CapitalsQuizViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 19.01.24.
//

import Foundation
import AVFoundation

final class CapitalsQuizViewModel: QuizProtocol, ObservableObject, AudioPlayerProtocol {
    
    var preferences: QuizPreferences = QuizPreferences(includeFlags: false, includeCapitals: true, includeCurrencies: false, enableTimer: true)
    var countries: [NewCountry] = []
    @Published var selectedCountry: NewCountry!
    @Published var possibleAnswers: [String] = []
    @Published var score: Int = 0
    @Published var increment: Int = 1
    @Published var quizCompleted: Bool = false
    @Published var selectedAnswer: String? = nil
    @Published var secondsElapsed: Int = 0
    @Published var isSoundOn: Bool = true
    @Published var currentQuestionType: QuestionType? = .capital
    @Published var previousQuestions: [NewCountry] = []
    var timer: Timer?
    var audioPlayer: AVAudioPlayer?
    var questionText: String = "What is the capital of "
    
    func checkAnswer(answer: String) {
        guard let country = selectedCountry else { return }
        selectedAnswer = answer
            if answer == country.capital {
                score += 1
                playSound(soundFileName: "correct")
            } else {
                playSound(soundFileName: "wrong")
            }
    }
  
}
