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
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.spacing = 20
        return stackView
    }()
    
    private let mainText: UILabel = {
        let label = UILabel()
        label.text = "Start a quiz"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 48)
        return label
    }()
    
    private let flagsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Flags", for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        return button
    }()
    
    private let capitalsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Capitals", for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCapitalsButton()
        setupFlagsButton()

    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(mainText)
        mainStackView.addArrangedSubview(flagsButton)
        mainStackView.addArrangedSubview(capitalsButton)
        mainStackView.setCustomSpacing(29, after: flagsButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
            let newViewModel = CapitalsQuizViewModel()
            newViewModel.countries = (self?.viewModel.countries)!
            let hostingController = UIHostingController(rootView: CapitalsQuiz(viewModel: newViewModel) )
            self?.navigationController?.pushViewController(hostingController, animated: true)
        }), for: .touchUpInside)
    }
    
    private func setupFlagsButton() {
        flagsButton.addAction(UIAction(handler: { [weak self] _ in
            let newViewModel = FlagsQuizViewModel()
            newViewModel.countries = self?.viewModel.countries ?? []
            let hostingController = UIHostingController(rootView: FlagsQuizView(viewModel: newViewModel))
            self?.navigationController?.pushViewController(hostingController, animated: true)
        }), for: .touchUpInside)
    }


}
