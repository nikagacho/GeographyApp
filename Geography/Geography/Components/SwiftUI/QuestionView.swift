//
//  QuestionView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 23.01.24.
//

import SwiftUI

struct QuestionView: View {
    //MARK: - Properties
    let question: String
    let countryName: String
    let score: Int
    //MARK: - Body
    var body: some View {
        VStack {
            VStack {
                (Text(question + " ")
                    .font(.myFont(size: 28))
                 +
                 Text(countryName + "?")
                    .foregroundColor(.blue)
                    .font(.myFont(size: 28)))
                .fixedSize(horizontal: false, vertical: true)
            }
            .frame(minHeight: 60)
            VStack {
                Text("Total Score: \(score)")
                    .bold()
                    .font(.myFont(size: 24))
                    .padding()
            }
        }
        .padding()
    }
}

