//
//  CustomQuizViewController.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 20.03.24.
//

import UIKit

class CustomQuizViewController: UIViewController {
    
    var router: Router?
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 28
        stackView.distribution = .fill
        return stackView
    }()
    
    private let typeStackViewOne: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private let typeStackViewTwo: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private let typeStackViewThree: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private let typeStackViewFour: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        return stackView
    }()
    
    private let mainLabel = CustomLabel(text: "Create your own Quiz!", size: 44)
    private let selectTypeLabel = CustomLabel(text: "Select the Type of Quiz", size: 32)
    private let flagsLabel = CustomLabel(text: "Flags", size: 24)
    private let capitalsLabel = CustomLabel(text: "Capitals", size: 24)
    private let currenciesLabel = CustomLabel(text: "Currencies", size: 24)
    private let typeSwitch1 = UISwitch()
    private let typeSwitch2 = UISwitch()
    private let typeSwitch3 = UISwitch()
    private let enableTimerLabel = CustomLabel(text: "Enable Timer", size: 24)
    private let timerSwitch = UISwitch()
    private let startButton = CustomButton(title: "Let's Go")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupStacks()
        setupConstraints()
        setCustomSpacing()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(mainStackView)
        timerSwitch.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        selectTypeLabel.textColor = .systemBlue
        enableTimerLabel.textColor = .systemBlue
    }
    
    private func setupStacks() {
        mainStackView.addArrangedSubview(mainLabel)
        mainStackView.addArrangedSubview(selectTypeLabel)
        mainStackView.addArrangedSubview(typeStackViewOne)
        typeStackViewOne.addArrangedSubview(flagsLabel)
        typeStackViewOne.addArrangedSubview(typeSwitch1)
        mainStackView.addArrangedSubview(typeStackViewTwo)
        typeStackViewTwo.addArrangedSubview(capitalsLabel)
        typeStackViewTwo.addArrangedSubview(typeSwitch2)
        mainStackView.addArrangedSubview(typeStackViewThree)
        typeStackViewThree.addArrangedSubview(currenciesLabel)
        typeStackViewThree.addArrangedSubview(typeSwitch3)
        mainStackView.addArrangedSubview(typeStackViewFour)
        typeStackViewFour.addArrangedSubview(enableTimerLabel)
        typeStackViewFour.addArrangedSubview(timerSwitch)
        mainStackView.addArrangedSubview(startButton)
    }
    
    private func setCustomSpacing() {
        mainStackView.setCustomSpacing(60, after: mainLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            startButton.heightAnchor.constraint(equalToConstant: 54)
        ])
    }

}