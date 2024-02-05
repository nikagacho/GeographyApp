//
//  StartQuizViewController.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 18.01.24.
//

import UIKit
import SwiftUI

class StartQuizViewController: UIViewController {
    
    let viewModel = StartQuizViewModel()
    var flowNavigator: FlowNavigator?
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray6
        stackView.spacing = 20
        return stackView
    }()
    
    private let mainText: CustomLabel = {
        let label = CustomLabel(text: "Choose your Quiz!", size: 48)
        return label
    }()
    
    private let flagsButton: CustomButton = {
        let button = CustomButton(title: "Flags")
        return button
    }()
    
    private let capitalsButton: CustomButton = {
        let button = CustomButton(title: "Capitals")
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .earth2
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCapitalsButton()
        setupFlagsButton()
    }
  
    private func setupUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(mainText)
        mainStackView.addArrangedSubview(flagsButton)
        mainStackView.addArrangedSubview(capitalsButton)
        mainStackView.setCustomSpacing(100, after: capitalsButton)
        mainStackView.addArrangedSubview(imageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            flagsButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 89),
            flagsButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -89),
            flagsButton.heightAnchor.constraint(equalToConstant: 58),
            capitalsButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 89),
            capitalsButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -89),
            capitalsButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }

    private func setupCapitalsButton() {
        capitalsButton.addAction(UIAction(handler: { [weak self] _ in
            self!.flowNavigator?.showCapitalsQuiz(countries: self!.viewModel.countries)
        }), for: .touchUpInside)
    }
    
    private func setupFlagsButton() {
        flagsButton.addAction(UIAction(handler: { [weak self] _ in
            self!.flowNavigator?.showFlagsQuiz(countries: self!.viewModel.countries)
        }), for: .touchUpInside)
    }
    
}
