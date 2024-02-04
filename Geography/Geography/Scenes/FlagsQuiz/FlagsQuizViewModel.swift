//
//  FlagsQuizViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 23.01.24.
//

import Foundation
import AVFoundation

class FlagsQuizViewModel: ObservableObject, QuizViewModelProtocol {
    
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
    
    func returnPossibleAnswers(country: NewCountry) -> [String] {
        var flagAnswers: [String] = [country.href.flag]
        print(country.name)
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
    
    private func playSound(soundFileName: String) {
        if isSoundOn == true {
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
