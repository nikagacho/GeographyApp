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
    
    var body: some View {
        VStack {
            Text("\(question) \(countryName)?")
                .font(.custom("LondrinaSolid-Regular", size: 30))
                .padding()
            VStack {
                Text("Total Score: \(score)")
                    .bold()
                    .font(.custom("LondrinaSolid-Regular", size: 24))
            }
        }
    }
}
