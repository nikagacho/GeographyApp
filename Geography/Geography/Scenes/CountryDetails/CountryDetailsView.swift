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
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let countryHeaderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let countryFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let capitalHeaderLabel = makeHeaderLabel(text: "Capital")
    private let capitalLabel = makeDetailLabel()
    private let continentHeaderLabel = makeHeaderLabel(text: "Continent")
    private let continentLabel = makeDetailLabel()
    private let populationHeaderLabel = makeHeaderLabel(text: "Population")
    private let populationLabel = makeDetailLabel()
    private let sizeHeaderLabel = makeHeaderLabel(text: "Size")
    private let sizeLabel = makeDetailLabel()
    private let currencyHeaderLabel = makeHeaderLabel(text: "Currency")
    private let currencyLabel = makeDetailLabel()
    
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
        let countryStackView = UIStackView(arrangedSubviews: [countryHeaderLabel, countryFlag])
        countryStackView.axis = .vertical
        countryStackView.spacing = 8
        
        mainStackView.addArrangedSubview(countryStackView)
        mainStackView.addArrangedSubview(makeDetailStack(headerLabel: capitalHeaderLabel, detailLabel: capitalLabel))
        mainStackView.addArrangedSubview(makeDetailStack(headerLabel: continentHeaderLabel, detailLabel: continentLabel))
        mainStackView.addArrangedSubview(makeDetailStack(headerLabel: populationHeaderLabel, detailLabel: populationLabel))
        mainStackView.addArrangedSubview(makeDetailStack(headerLabel: sizeHeaderLabel, detailLabel: sizeLabel))
        mainStackView.addArrangedSubview(makeDetailStack(headerLabel: currencyHeaderLabel, detailLabel: currencyLabel))
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
    
    private static func makeHeaderLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.text = text
        return label
    }
    
    private static func makeDetailLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20)
        return label
    }
    
    private func makeDetailStack(headerLabel: UILabel, detailLabel: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [headerLabel, detailLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }
    
    public func configure(with country: NewCountry, image: UIImage?) {
        countryHeaderLabel.text = country.name
        capitalLabel.text = country.capital
        continentLabel.text = country.continent
        populationLabel.text = country.population
        sizeLabel.text = country.size
        currencyLabel.text = country.currency
        countryFlag.image = image
    }
}


