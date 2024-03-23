//
//  FlagsQuizViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 23.01.24.
//

import Foundation
import AVFoundation

final class FlagsQuizViewModel: QuizProtocol, AudioPlayerProtocol, ObservableObject {
    
    var preferences: QuizPreferences = QuizPreferences(includeFlags: true, includeCapitals: false, includeCurrencies: false, enableTimer: true)
    @Published var countries: [NewCountry] = []
    @Published var selectedCountry: NewCountry!
    @Published var possibleAnswers: [String] = []
    @Published var score: Int = 0
    @Published var increment: Int = 1
    @Published var quizCompleted: Bool = false
    @Published var selectedAnswer: String? = nil
    @Published var secondsElapsed: Int = 0
    @Published var isSoundOn: Bool = true
    @Published var currentQuestionType: QuestionType? = .flag
    @Published var previousQuestions: [NewCountry] = []
    var timer: Timer?
    var audioPlayer: AVAudioPlayer?
    var questionText: String = "Which is the flag of "
    
    func checkAnswer(answer: String) {
        guard let country = selectedCountry else { return }
        selectedAnswer = answer
            if answer == country.href.flag {
                score += 1
                playSound(soundFileName: "correct")
            } else {
                playSound(soundFileName: "wrong")
            }
    }
  
}

