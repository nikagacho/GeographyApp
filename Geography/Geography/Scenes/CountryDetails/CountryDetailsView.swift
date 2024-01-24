//
//  CountryDetailsView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 18.01.24.
//

import UIKit

class CountryDetailsView: UIViewController {
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let countryField: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "Country Name:"
        return label
    }()
    
    private let capitalField: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .body)
        label.text = "Capital Name:"
        return label
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let countryFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let capitalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(mainStackView)
        view.backgroundColor = .systemBackground
        setupStacks()
        setupConstraints()
    }
    
    private func setupStacks() {
        let countryInfoStackView = UIStackView(arrangedSubviews: [countryField, countryLabel])
        countryInfoStackView.axis = .horizontal
        countryInfoStackView.spacing = 10
        countryInfoStackView.alignment = .leading
        let capitalInfoStackView = UIStackView(arrangedSubviews: [capitalField, capitalLabel])
        capitalInfoStackView.axis = .horizontal
        capitalInfoStackView.spacing = 10
        capitalInfoStackView.alignment = .leading
        mainStackView.addArrangedSubview(countryFlag)
        mainStackView.addArrangedSubview(countryInfoStackView)
        mainStackView.addArrangedSubview(capitalInfoStackView)
        countryFlag.heightAnchor.constraint(equalTo: countryFlag.widthAnchor, multiplier: 2/3).isActive = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
    }
    
    public func configure(with country: NewCountry) {
        countryLabel.text = country.name
        capitalLabel.text = country.capital
//        countryFlag.image = country.flag.emojiImage()
    }
    
}

