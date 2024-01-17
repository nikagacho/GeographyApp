//
//  CustomCell.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 17.01.24.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 8
        stackView.layer.borderWidth = 1
        return stackView
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let countryFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let capitalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    static let cellIdentifier = "CustomCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.countryFlag.image = nil
    }
    
    public func configure(with country: Country) {
        countryLabel.text = country.name.common
        capitalLabel.text = country.capital.first
        countryFlag.image = country.flag.emojiImage()
    }
    
    private func setupUI() {
        self.backgroundColor = .systemBackground
        self.addSubview(mainStackView)
        setupStackView()
        setupConstraints()
    }
    
    private func setupStackView() {
        mainStackView.addArrangedSubview(countryLabel)
        mainStackView.addArrangedSubview(capitalLabel)
        mainStackView.addArrangedSubview(countryFlag)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
        ])
    }
}
