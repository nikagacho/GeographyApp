//
//  CountryDetailsView.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 18.01.24.
//

import UIKit

final class CountryDetailsView: UIViewController {
    //MARK: - UIElements
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.backgroundColor = .systemGray6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let countryHeaderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        label.font = UIFont.myFont(ofSize: 30)
        label.numberOfLines = 0
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return label
    }()
    
    private let countryFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowRadius = 4
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.clipsToBounds = false
        return imageView
    }()
    
    private let separator: UIView = {
        let separator = UIView()
        separator.backgroundColor = .systemGray3
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
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
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStackView.alpha = 0
        UIView.animate(withDuration: 1) {
            self.mainStackView.alpha = 1
        }
    }
    //MARK: - SetupUI
    private func setupUI() {
        view.addSubview(mainStackView)
        view.backgroundColor = .systemGray6
        setupStacks()
        setupConstraints()
    }
    
    private func setupStacks() {
        let countryStackView = UIStackView(arrangedSubviews: [countryHeaderLabel, countryFlag])
        countryStackView.axis = .vertical
        countryStackView.spacing = 8
        mainStackView.addArrangedSubview(countryStackView)
        addSeparatorView()
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
    //MARK: - Methods to make reusable labels
    private static func makeHeaderLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.myFont(ofSize: 24)
        label.text = text
        label.textColor = .darkGray
        return label
    }
    
    private static func makeDetailLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.myFont(ofSize: 20)
        label.textColor = .black
        return label
    }
    
    private func makeDetailStack(headerLabel: UILabel, detailLabel: UILabel) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [headerLabel, detailLabel])
        stackView.axis = .vertical
        stackView.backgroundColor = UIColor.systemGray5
        stackView.layer.cornerRadius = 20
        stackView.spacing = 4
        return stackView
    }
    
    private func addSeparatorView() {
        let separator = UIView()
        separator.backgroundColor = .systemGray5
        separator.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(separator)
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    //MARK: - Configure with data
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


