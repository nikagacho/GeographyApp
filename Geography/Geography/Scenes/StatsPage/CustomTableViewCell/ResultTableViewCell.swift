//
//  CustomTableCell.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 05.02.24.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    //MARK: - TableView Properties
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.myFont(ofSize: 20)
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.myFont(ofSize: 20)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.myFont(ofSize: 20)
        return label
    }()
    
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Setup Cell
    private func setupUI() {
        contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(scoreLabel)
        mainStackView.addArrangedSubview(timeLabel)
        mainStackView.addArrangedSubview(dateLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    public func configure(with quizResult: QuizResult) {
        scoreLabel.text = "Score: \(quizResult.score)"
        timeLabel.text = "Time: \(formatSeconds(seconds: quizResult.time))"
        dateLabel.text = "\(formatDate(quizResult.date))"
        scoreLabel.accessibilityLabel = "Score \(quizResult.score)"
        timeLabel.accessibilityLabel = "Time \(quizResult.time) seconds"
        dateLabel.accessibilityLabel = "Date \(formatDate(quizResult.date))"
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    private func formatSeconds(seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: TimeInterval(seconds)) ?? "0:00"
    }
    
}
