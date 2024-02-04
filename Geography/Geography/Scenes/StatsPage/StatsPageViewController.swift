//
//  StatsPageViewController.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 03.02.24.
//

import UIKit

class StatsPageViewController: UIViewController {
    
    var viewModel = StatsPageViewModel()
    var flowNavigator: FlowNavigator?
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 8
        return stackView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = UIColor.systemGray4.cgColor
        tableView.clipsToBounds = true
        return tableView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Reset Data", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let topLabel: UILabel = createSectionLabel(text: "Your Best Results", fontSize: 30, backgroundColor: .systemBlue, textColor: .white)
    private let headerText: UILabel = createSectionLabel(text: "Your Quiz History", fontSize: 30, backgroundColor: .systemBlue, textColor: .white)
    private let firstResult = createSectionLabel(fontSize: 18)
    private let secondResult = createSectionLabel(fontSize: 18)
    private let thirdResult = createSectionLabel(fontSize: 18)
    private let totalQuestionsText = createSectionLabel(fontSize: 18)
    private let totalCorrectAnswersText = createSectionLabel(fontSize: 18)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupTableView()
        setupTopThree()
        setupTotals()
        setupResetButton()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topLabel)
        mainStackView.addArrangedSubview(firstResult)
        mainStackView.addArrangedSubview(secondResult)
        mainStackView.addArrangedSubview(thirdResult)
        addSeparatorView()
        mainStackView.addArrangedSubview(headerText)
        mainStackView.addArrangedSubview(tableView)
        addSeparatorView()
        mainStackView.addArrangedSubview(totalCorrectAnswersText)
        mainStackView.addArrangedSubview(totalQuestionsText)
        mainStackView.addArrangedSubview(button)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    private func setupTopThree() {
        let topResults = viewModel.topThreeResults
        if topResults.count > 0 {
            let first = topResults[0]
            firstResult.text = "🥇 Score: \(first.score), Time: \(first.time) seconds 🥇"
        } else {
            firstResult.text = "1st: N/A"
        }
        if topResults.count > 1 {
            let second = topResults[1]
            secondResult.text = "🥈 Score: \(second.score), Time: \(second.time) seconds 🥈"
        } else {
            secondResult.text = "2nd: N/A"
        }
        if topResults.count > 2 {
            let third = topResults[2]
            thirdResult.text = "🥉 Score: \(third.score), Time: \(third.time) seconds 🥉"
        } else {
            thirdResult.text = "3rd: N/A"
        }
    }
    
    private func setupTotals() {
        let totalScore = viewModel.quizResults.reduce(0) { $0 + $1.score }
        let totalQuestions = viewModel.quizResults.count * 10
        totalCorrectAnswersText.text = "\(totalScore) - Total Correct"
        totalQuestionsText.text = "\(totalQuestions) - Total Questions"
    }
    
    private static func createSectionLabel(text: String = "", fontSize: CGFloat, backgroundColor: UIColor = .clear, textColor: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.font = .systemFont(ofSize: fontSize, weight: .regular)
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return label
    }
    
    private func addSeparatorView() {
        let separator = UIView()
        separator.backgroundColor = .systemGray5
        separator.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(separator)
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Resetting the data", message: "You're about to reset your statistics, are you sure? This can't be changed back", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { _ in
            self.viewModel.resetAction()
            self.flowNavigator?.goBack()
        }))
        
        self.present(alert, animated: true)
    }
    
    private func setupResetButton() {
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.showAlert()
        }), for: .touchUpInside)
    }
}


extension StatsPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfResults
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.formattedResult(for: indexPath.row)
        cell.textLabel?.font = .systemFont(ofSize: 18)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .center
        return cell
    }
}
