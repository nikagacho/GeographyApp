//
//  Timer.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 01.02.24.
//

import SwiftUI

struct TimerView<ViewModel: QuizViewModelProtocol & ObservableObject>: View {
    @ObservedObject var viewModel: ViewModel

    var increment: Int
    
    var body: some View {
        HStack {
            Text("\(increment)/10")
                .font(.custom("LondrinaSolid-Regular", size: 22))
            Text("\(formattedTime(seconds: viewModel.secondsElapsed))")
                .padding()
                .font(.custom("LondrinaSolid-Regular", size: 22))
        }
    }
    
}
