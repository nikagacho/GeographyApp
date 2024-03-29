//
//  QuizCompletionView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 23.01.24.
//

import SwiftUI

struct QuizCompletionView: View {
    //MARK: - Properties
    let score: Int
    var time: Int
    let restartAction: () -> Void
    let goBack: () -> Void
    var shouldUseTime: Bool
    //MARK: - Body
    var body: some View {
        ZStack {
            if score > 7 {
                CustomFireworksView()
                    .edgesIgnoringSafeArea(.all)
            }
            VStack(spacing: 36) {
                Text("Quiz Completed!")
                    .font(.myFont(size: 40))
                resultImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .cornerRadius(16)
                    .shadow(radius: 40)
                Text("Your score: \(score) / 10")
                    .font(.myFont(size: 30))
                if shouldUseTime {
                    Text("Time Elapsed: \(formattedTime(seconds: time))")
                        .font(.myFont(size: 24))
                }
                ShareLink(
                    item: "I just scored \(score) out of 10 in the Geography Quiz, can you beat me?",
                    label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                )
                HStack {
                    Button("Restart") {
                        restartAction()
                    }
                    .buttonStyle(backgroundColor: Color.blue)
                    Button("Go Back") {
                        goBack()
                    }
                    .buttonStyle(backgroundColor: Color.blue)
                }
            }
            .onAppear {
                if shouldUseTime {
                    let result = QuizResult(score: score, time: time, date: Date())
                    UserDefaults.standard.saveQuizResult(result)
                }
            }
        }
    }
    //MARK: - Image Picker based on results
    private var resultImage: Image {
        switch score {
        case 8...10:
            return Image("topResult")
        case 5...7:
            return Image("midResult")
        default:
            return Image("lowResult")
        }
    }
}


