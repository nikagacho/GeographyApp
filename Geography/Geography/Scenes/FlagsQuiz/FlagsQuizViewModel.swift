//
//  FlagsQuizViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 23.01.24.
//

import Foundation
import AVFoundation

class FlagsQuizViewModel: ObservableObject, QuizViewModelProtocol {
    //MARK: - Properties
    var countries: [NewCountry] = []
    var question = "Which one is the flag of "
    @Published var selectedCountry: NewCountry!
    @Published var possibleAnswers: [String] = []
    @Published var score = 0
    @Published var increment = 1
    @Published var quizCompleted = false
    @Published var selectedAnswer: String? = nil
    @Published var secondsElapsed: Int = 0
    @Published var isSoundOn = true
    var previousQuestions: [NewCountry] = []
    var timer: Timer?
    private var audioPlayer: AVAudioPlayer?
    //MARK: - Methods
    func returnPossibleAnswers(country: NewCountry) -> [String] {
        var flagAnswers: [String] = [country.href.flag]
        while flagAnswers.count < 4 {
            let randomCountry = countries.randomElement()
            let randomFlag = randomCountry?.href.flag ?? ""
            
            if randomCountry?.name != country.name && !flagAnswers.contains(randomFlag) {
                flagAnswers.append(randomFlag)
            }
        }
        return flagAnswers.shuffled()
    }
    
    func checkAnswer(answer: String) {
        selectedAnswer = answer
        guard let country = selectedCountry else { return }
        if answer == country.href.flag {
            score += 1
            playSound(soundFileName: "correct")
        } else {
            playSound(soundFileName: "wrong")
        }
    }
    //MARK: - Sound Player
    private func playSound(soundFileName: String) {
        if isSoundOn {
            guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else { return }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Unable to locate audio file: \(soundFileName)")
            }
        }
    }
}

