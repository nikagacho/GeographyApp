//
//  Timer.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 01.02.24.
//

import SwiftUI

struct TimerView<ViewModel: QuizViewModelProtocol & ObservableObject>: View {
    //MARK: - Properties
    @ObservedObject var viewModel: ViewModel
    var increment: Int
    //MARK: - Body
    var body: some View {
        HStack {
            Text("\(increment)/10")
                .font(.myFont(size: 22))
            Text("\(formattedTime(seconds: viewModel.secondsElapsed))")
                .padding()
                .font(.myFont(size: 22))
        }
    }
    
}
