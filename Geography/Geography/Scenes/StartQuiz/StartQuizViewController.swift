//
//  StartQuizViewController.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 18.01.24.
//

import UIKit
import SwiftUI

final class StartQuizViewController: UIViewController {
    //MARK: - Properties
    let viewModel = StartQuizViewModel()
    var router : Router?
    //MARK: - UI Elements
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray6
        stackView.spacing = 20
        return stackView
    }()
    
    private let mainText = CustomLabel(text: "Choose your Quiz", size: 48)
    private let flagsButton = CustomButton(title: "Flags")
    private let capitalsButton = CustomButton(title: "Capitals")
    private let customButton = CustomButton(title: "Custom Quiz")
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .earth2
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCapitalsButton()
        setupFlagsButton()
        setupCustomButton()
    }
    //MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(mainText)
        mainStackView.addArrangedSubview(flagsButton)
        mainStackView.addArrangedSubview(capitalsButton)
        mainStackView.addArrangedSubview(customButton)
        mainStackView.setCustomSpacing(100, after: customButton)
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
            capitalsButton.heightAnchor.constraint(equalToConstant: 58),
            customButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 89),
            customButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -89),
            customButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    //MARK: - Setup Buttons
    private func setupCapitalsButton() {
        capitalsButton.addAction(UIAction(handler: { [weak self] _ in
            if let strongSelf = self {
                strongSelf.router?.showCapitalsQuiz(countries: strongSelf.viewModel.countries)
            }
        }), for: .touchUpInside)
    }
    private func setupFlagsButton() {
        flagsButton.addAction(UIAction(handler: { [weak self] _ in
            if let strongSelf = self {
                strongSelf.router?.showFlagsQuiz(countries: strongSelf.viewModel.countries)
            }
        }), for: .touchUpInside)
    }
    
    private func setupCustomButton() {
        customButton.addAction(UIAction(handler: { [weak self] _ in
            let vc = CustomQuizViewController()
            if let strongSelf = self {
                strongSelf.router?.presentViewController(with: vc)
            }
        }), for: .touchUpInside)
    }
}
