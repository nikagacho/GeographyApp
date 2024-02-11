//
//  HomePageViewController.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 16.01.24.
//

import UIKit

class HomePageViewController: UIViewController {
    //MARK: - Properties
    let viewModel = HomePageViewModel(countries: [])
    var router: Router?
    //MARK: - UI Elements
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private let mainText: CustomLabel = {
        let label = CustomLabel(text: "Welcome to Geography Quiz!", size: 44)
        return label
    }()
    
    private let quizButton: CustomButton = {
        let button = CustomButton(title: "Quiz")
        return button
    }()

    private let learnButton: CustomButton = {
        let button = CustomButton(title: "Learn")
        return button
    }()
    
    private let statsButton: CustomButton = {
        let button = CustomButton(title: "Statistics")
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .earth2
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    //MARK: - SetupUI
    private func setupView() {
        view.addSubview(mainStackView)
        view.backgroundColor = .systemGray6
        setupStack()
        setupConstraints()
        setupLearnButton()
        setupQuizButton()
        setupStatsButton()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func setupStack() {
        mainStackView.addArrangedSubview(mainText)
        mainStackView.addArrangedSubview(quizButton)
        mainStackView.addArrangedSubview(learnButton)
        mainStackView.addArrangedSubview(statsButton)
        mainStackView.addArrangedSubview(imageView)
        mainStackView.setCustomSpacing(100, after: statsButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quizButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 89),
            quizButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -89),
            learnButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 89),
            learnButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -89),
            statsButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -89),
            statsButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 89),
            statsButton.heightAnchor.constraint(equalToConstant: 58),
            quizButton.heightAnchor.constraint(equalToConstant: 58),
            learnButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    //MARK: - Setup Buttons
    private func setupLearnButton() {
        viewModel.delegate = self
        learnButton.addAction(UIAction(handler: { [weak self] _ in
            self!.viewModel.didTapLearnButton()
        }), for: .touchUpInside)
    }
    
    private func setupQuizButton() {
        viewModel.delegate = self
        quizButton.addAction(UIAction(handler: { [weak self] _ in
            self!.viewModel.didTapQuizButton()
        }), for: .touchUpInside)
    }
    
    private func setupStatsButton() {
        statsButton.addAction(UIAction(handler: { [weak self] _ in
            let statsVC = StatsPageViewController()
            statsVC.router = self?.router
            self?.navigationController?.pushViewController(statsVC, animated: true)
        }), for: .touchUpInside)
    }
    
}
//MARK: - Delegate
extension HomePageViewController: HomePageViewModelDelegate {
    func navigateToQuizPage(with countries: [NewCountry]) {
        let quizPage = StartQuizViewController()
        quizPage.viewModel.countries = viewModel.countries
        quizPage.router = router
        navigationController?.pushViewController(quizPage, animated: true)
    }
    
    func navigateToLearningPage(with countries: [NewCountry]) {
        let learningPage = LearningPageViewController()
        learningPage.viewModel.countries = viewModel.countries
        learningPage.viewModel.filteredCountries = viewModel.countries
        navigationController?.pushViewController(learningPage, animated: true)
    }
}

