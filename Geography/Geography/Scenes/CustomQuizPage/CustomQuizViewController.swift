//
//  CustomQuizViewController.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 20.03.24.
//

import UIKit

class CustomQuizViewController: UIViewController {
    
    var router: Router?
    var viewModel = CustomQuizViewModel()
    
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
    
    private let mainLabel = CustomLabel(text: "Create your own Quiz!", size: 44, shouldUseShadows: false)
    private let selectTypeLabel = CustomLabel(text: "Select the Type of Quiz", size: 32, shouldUseShadows: false)
    private let warningLabel = CustomLabel(text: "Note: You need to select at least 1 quiz type", size: 16, shouldUseShadows: false)
    private let flagsLabel = CustomLabel(text: "Flags", size: 24, shouldUseShadows: false)
    private let capitalsLabel = CustomLabel(text: "Capitals", size: 24, shouldUseShadows: false)
    private let currenciesLabel = CustomLabel(text: "Currencies", size: 24, shouldUseShadows: false)
    private let typeSwitch1 = UISwitch()
    private let typeSwitch2 = UISwitch()
    private let typeSwitch3 = UISwitch()
    private let enableTimerLabel = CustomLabel(text: "Enable Timer", size: 24, shouldUseShadows: false)
    private let timerSwitch = UISwitch()
    private let startButton = CustomButton(title: "Let's Go")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupStacks()
        setupConstraints()
        setCustomSpacing()
        setupSwitches()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(mainStackView)
        timerSwitch.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        selectTypeLabel.textColor = .systemBlue
        enableTimerLabel.textColor = .systemBlue
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    private func setupSwitches() {
        typeSwitch1.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        typeSwitch2.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        typeSwitch3.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        timerSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    }
    
    private func setupStacks() {
        mainStackView.addArrangedSubview(mainLabel)
        mainStackView.addArrangedSubview(selectTypeLabel)
        mainStackView.addArrangedSubview(warningLabel)
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
    
    @objc private func switchChanged() {
            viewModel.updatePreferences(flags: typeSwitch1.isOn, capitals: typeSwitch2.isOn, currencies: typeSwitch3.isOn, timer: timerSwitch.isOn)
        }
    
    @objc private func startButtonTapped() {
        if viewModel.checkIfTypeExists() {
            let preferences = viewModel.getPreferences()
            router?.showMixedQuiz(preferences: preferences, countries: self.viewModel.countries )
            self.dismiss(animated: true)
        } else {
            AlertManager.showAlert(on: self, title: viewModel.noTypeTitle , message: viewModel.noTypeText)
        }
    }
    
}
