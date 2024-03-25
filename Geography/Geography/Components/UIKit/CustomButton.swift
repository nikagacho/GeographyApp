//
//  CustomButton.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 05.02.24.
//

import UIKit

final class CustomButton: UIButton {
    //MARK: - Custom Init
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    //MARK: - Button Setup
    private func setupButton() {
        titleLabel?.font = UIFont.myFont(ofSize: 24)
        backgroundColor = UIColor(named: "ButtonColor")
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.3
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.blue.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.cornerRadius = 20
        layer.insertSublayer(gradientLayer, at: 0)
        var transform = CATransform3DIdentity
        transform.m34 = -1.0 / 500
        transform = CATransform3DRotate(transform, 10 * CGFloat.pi / 180, 1, 0, 0)
        layer.transform = transform
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
