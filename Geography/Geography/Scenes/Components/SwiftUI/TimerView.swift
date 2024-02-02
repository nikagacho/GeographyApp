//
//  Timer.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 01.02.24.
//

import SwiftUI

struct TimerView: View {
    @State private var secondsElapsed = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("Time: \(formattedTime(seconds: secondsElapsed))")
            .onReceive(timer) { _ in
                self.secondsElapsed += 1
            }
    }
    
    private func formattedTime(seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        
        return formatter.string(from: TimeInterval(seconds)) ?? "0:00"
    }
    
    func resetTimer() {
        secondsElapsed = 0
    }
    
    func stopTimerAndRetrieveTime() -> Int {
        timer.upstream.connect().cancel()
        return secondsElapsed
    }
}
