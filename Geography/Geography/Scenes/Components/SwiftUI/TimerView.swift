//
//  Timer.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 01.02.24.
//

import SwiftUI

struct TimerView<ViewModel: QuizViewModelProtocol & ObservableObject>: View {
    @ObservedObject var viewModel: ViewModel
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("Time: \(formattedTime(seconds: viewModel.secondsElapsed))")
    }
    
}
