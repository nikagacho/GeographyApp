//
//  UIColorExtension.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 25.03.24.
//
import UIKit

extension UIColor {
    static var backgroundColor: UIColor {
        return UIColor(named: "BackgroundColor") ?? .systemGray6
    }

    static var textColor: UIColor {
        return UIColor(named: "TextColor") ?? .label
    }
    
    static var buttonColor: UIColor {
        return UIColor(named: "ButtonColor") ?? .systemBlue
    }
    
    static var headerColor: UIColor {
        return UIColor(named: "HeaderTextColor") ?? .white
    }
}
