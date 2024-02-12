//
//  ShakeView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 11.02.24.
//

import SwiftUI

struct Shake: GeometryEffect {
    //MARK: - Properties
    var amount: CGFloat = 10
    var shakesPerUnit: CGFloat = 3
    var animatableData: CGFloat
    //MARK: - Shake
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: amount * sin(animatableData * .pi * shakesPerUnit), y: 0))
    }
}
