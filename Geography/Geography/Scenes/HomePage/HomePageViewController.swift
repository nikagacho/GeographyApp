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
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let learnButton: UIButton = {
        let button = UIButton()
        button.setTitle("Learn", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .earth
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        setupQuizButton()
    }
    
    private func setupStack() {
        mainStackView.addArrangedSubview(mainText)
        mainStackView.addArrangedSubview(quizButton)
        mainStackView.addArrangedSubview(learnButton)
        mainStackView.addArrangedSubview(imageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            quizButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 89),
            quizButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -89),
            learnButton.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 89),
            learnButton.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -89),
            quizButton.heightAnchor.constraint(equalToConstant: 58),
            learnButton.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
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

}

extension HomePageViewController: HomePageViewModelDelegate {
    func navigateToQuizPage(with countries: [Country]) {
        let quizPage = StartQuizViewController()
        quizPage.viewModel.countries = viewModel.countries
        navigationController?.pushViewController(quizPage, animated: true)
    }
    
    func navigateToLearningPage(with countries: [Country]) {
        let learningPage = LearningPageViewController()
        learningPage.viewModel.countries = viewModel.countries
        navigationController?.pushViewController(learningPage, animated: true)
    }
}

