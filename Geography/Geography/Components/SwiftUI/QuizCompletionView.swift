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
        VStack(spacing: 36) {
            Text("Quiz Completed!")
                .font(.myFont(size: 40))
            Text("Your score: \(score) / 10")
                .font(.myFont(size: 30))
            Text("Time Elapsed: \(formattedTime(seconds: time))")
                .font(.myFont(size: 24))
            HStack {
                Button("Restart Quiz", action: restartAction)
                    .padding()
                    .font(.myFont(size: 20))
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                Button("Go Back", action: goBack)
                    .padding()
                    .font(.myFont(size: 20))
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

