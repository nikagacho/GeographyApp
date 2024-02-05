//
//  FontExtension.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 05.02.24.
//

import UIKit
import SwiftUI

extension UIFont {
    static func myFont(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "LondrinaSolid-Regular", size: size)
    }
}

extension Font {
    static func myFont(size: CGFloat) -> Font {
        return Font.custom("LondrinaSolid-Regular", size: size)
    }
}
