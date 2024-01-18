//
//  CapitalsQuiz.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 19.01.24.
//

import SwiftUI

struct CapitalsQuiz: View {
    
    var viewModel: CapitalsQuizViewModel
    @State var selectedCountry: Country?
    @State var possibleAnswers: [String] = []
    @State var increment = 1
    
    var body: some View {
        VStack {
            if let country = selectedCountry {
                Text("\(viewModel.question) \(country.name.common)?")
                    .font(.title)
                    .padding()
                Text("\(increment) / 10")
                ForEach(possibleAnswers, id: \.self) { capital in
                    Button(action: {
                        if increment < 10 {
                            let status = viewModel.checkAnswer(country: country, capital: capital)
                            if status == true {
                                increment += 1
                                loadNewQuestion()
                            } else {
                                
                            }
                        }
                    }, label: {
                        Text(capital)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    })
                    .padding(.horizontal)
                }
            } else {
                Text("Loading QUIZ")
                    .onAppear {
                        loadNewQuestion()
                    }
            }
        }
    }
    
    private func loadNewQuestion() {
        guard let randomCountry = viewModel.countries.randomElement() else { return }
        selectedCountry = randomCountry
        possibleAnswers = viewModel.returnPossibleAnswers(country: selectedCountry! )
    }
}

#Preview {
    CapitalsQuiz(viewModel: CapitalsQuizViewModel())
}
