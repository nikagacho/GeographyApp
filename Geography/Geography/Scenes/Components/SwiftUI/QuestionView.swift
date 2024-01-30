//
//  QuestionView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 23.01.24.
//

import SwiftUI

struct QuestionView: View {
    let question: String
    let countryName: String
    let score: Int
    let increment: Int
    
    var body: some View {
        VStack {
            Text("\(increment)/10")
            Text("\(question) \(countryName)?")
                .font(.title)
                .padding()
            VStack {
                Text("Total Score: \(score)")
                    .bold()
            }
        }
    }
}
