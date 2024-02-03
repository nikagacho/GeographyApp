//
//  StatsPageViewController.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 03.02.24.
//

import UIKit

class StatsPageViewController: UIViewController {
    
    var viewModel = StatsPageViewModel()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let headerText: UILabel = {
        let label = UILabel()
        label.text = "Your Quiz History"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Best Results"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    private let firstResult: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26)
        return label
    }()
    
    private let secondResult: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22)
        return label
    }()
    
    private let thirdResult: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupTableView()
        setupTopThree()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(headerText)
        mainStackView.addArrangedSubview(tableView)
        mainStackView.addArrangedSubview(topLabel)
        mainStackView.addArrangedSubview(firstResult)
        mainStackView.addArrangedSubview(secondResult)
        mainStackView.addArrangedSubview(thirdResult)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
    
}

extension StatsPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfResults
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.formattedResult(for: indexPath.row)
        cell.textLabel?.font = .systemFont(ofSize: 20)
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    
}
