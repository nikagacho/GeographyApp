//
//  QuizCompletionView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 23.01.24.
//

import SwiftUI

struct QuizCompletionView: View {
    let score: Int
    var restartAction: () -> Void

    var body: some View {
        VStack {
            Text("Quiz Completed!")
                .font(.largeTitle)
            Text("Your score: \(score) / 10")
                .font(.title)
            Button("Restart Quiz", action: restartAction)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        
        }
    }
}

