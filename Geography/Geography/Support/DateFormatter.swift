//
//  DateFormatter.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 17.01.24.
//

import SwiftUI
import UIKit
//MARK: - DateFormatter for Seconds/Dates
//MARK: SwiftUI
extension View {
    func formattedTime(seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(seconds)) ?? "0:00"
    }
}
//MARK: UIKit
extension Date {
    func formattedAsMediumDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: self)
    }
}

