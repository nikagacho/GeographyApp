//
//  HomePageViewController.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 16.01.24.
//

import UIKit

class HomePageViewController: UIViewController {
    
    private let viewModel = HomePageViewModel()
    
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
        label.text = "Welcome to Geography"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()
    
    private let quizButton: UIButton = {
        let button = UIButton()
        button.setTitle("Quiz", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 16
        return button
    }()
    
    private let learnButton: UIButton = {
        let button = UIButton()
        button.setTitle("Learn", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 16
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.fetchData()
    }
    
    private func setupView() {
        view.addSubview(mainStackView)
        view.backgroundColor = .white
        setupStack()
        setupConstraints()
        setupLearnButton()
    }
    
    private func setupStack() {
        mainStackView.addArrangedSubview(mainText)
        mainStackView.addArrangedSubview(quizButton)
        mainStackView.addArrangedSubview(learnButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            quizButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            quizButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -20),
            learnButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 20),
            learnButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -20),
            quizButton.heightAnchor.constraint(equalToConstant: 50),
            learnButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupLearnButton() {
        viewModel.delegate = self
        learnButton.addAction(UIAction(handler: { [weak self] _ in
            self!.viewModel.didTapButton()
        }), for: .touchUpInside)
    }

}

extension HomePageViewController: LearningViewModelDelegate {
    func navigateToLearningPage(with countries: [Country]) {
        let learningPage = LearningPageViewController()
        learningPage.viewModel.countries = viewModel.countries
        navigationController?.pushViewController(learningPage, animated: true)
    }
}

