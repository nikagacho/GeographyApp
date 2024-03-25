//
//  CustomLabel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 05.02.24.
//

import UIKit

final class CustomLabel: UILabel {
    //MARK: - Custom Init
    init(text: String, size: CGFloat, shouldUseShadows: Bool? = true) {
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont.myFont(ofSize: size)
        self.textColor = .black
        setupLabel()
        if shouldUseShadows ?? false {
            addShadows()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    //MARK: - Label Setup
    private func setupLabel() {
        textAlignment = .center
        textColor = UIColor(named: "TextColor")
        numberOfLines = 2
    }
    
    private func addShadows() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 500
        transform = CATransform3DRotate(transform, 10 * CGFloat.pi / 180, 1, 0, 0)
        layer.transform = transform
    }
    
}

