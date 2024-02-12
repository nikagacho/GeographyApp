//
//  ButtonModifierView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 11.02.24.
//

import SwiftUI

struct ButtonModifierView: ViewModifier {
    //MARK: - Properties
    var backgroundColor: Color
    var foregroundColor: Color = .white
    var fontSize: CGFloat = 24
    var opacity: Double
    //MARK: - Modifier
    func body(content: Content) -> some View {
        content
            .font(.myFont(size: fontSize))
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(10)
            .opacity(opacity)
            .padding(.horizontal)
    }
}
//MARK: - View Extension
extension View {
    func buttonStyle(backgroundColor: Color, foregroundColor: Color = .white, fontSize: CGFloat = 24, opacity: Double = 1) -> some View {
        self.modifier(ButtonModifierView(backgroundColor: backgroundColor, foregroundColor: foregroundColor, fontSize: fontSize, opacity: opacity))
    }
}

