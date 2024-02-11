//
//  CapitalsQuizViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 19.01.24.
//

import Foundation
import AVFoundation

class CapitalsQuizViewModel: ObservableObject, QuizViewModelProtocol {
    //MARK: - Properties
    var countries: [NewCountry] = []
    var question = "What is the Capital City of "
    @Published var selectedCountry: NewCountry!
    var possibleAnswers: [String] = []
    @Published var score = 0
    @Published var increment = 1
    @Published var quizCompleted = false
    @Published var selectedAnswer: String? = nil
    @Published var secondsElapsed = 0
    @Published var isSoundOn = true
    var previousQuestions: [NewCountry] = []
    private var audioPlayer: AVAudioPlayer?
    var timer: Timer?
    //MARK: - Methods
    func returnPossibleAnswers(country: NewCountry) -> [String] {
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

    func checkAnswer(answer: String) {
        selectedAnswer = answer
        guard let country = selectedCountry else { return }
        if answer == country.capital {
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
