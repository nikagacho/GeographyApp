//
//  QuizCompletionView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 23.01.24.
//

import SwiftUI

struct QuizCompletionView: View {
    let score: Int
    var time: Int
    var restartAction: () -> Void
    var goBack: () -> Void

    var body: some View {
        VStack {
            Text("Quiz Completed!")
                .font(.largeTitle)
            Text("Your score: \(score) / 10")
                .font(.title)
            Text("Time Elapsed: \(formattedTime(seconds: time))")
            HStack {
                Button("Restart Quiz", action: restartAction)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                Button("Home", action: goBack)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        
        }
        .onAppear {
            let result = QuizResult(score: score, time: time, date: Date())
            UserDefaults.standard.saveQuizResult(result)
        }
    }
}

