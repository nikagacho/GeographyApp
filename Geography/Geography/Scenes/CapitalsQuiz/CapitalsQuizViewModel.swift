//
//  CapitalsQuizViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 19.01.24.
//

import Foundation
import AVFoundation

class CapitalsQuizViewModel: ObservableObject, QuizViewModelProtocol {
    
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
        guard let url = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else { return }
        
        if isSoundOn == true {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Unable to locate audio file: \(soundFileName)")
            }
        }
    }
    
    
}
