//
//  CustomCell.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 17.01.24.
//

import UIKit

final class CustomCell: UICollectionViewCell {
    //MARK: - Cell Elements
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 8
//        stackView.layer.borderWidth = 2
//        stackView.layer.borderColor = CGColor.init(red: 255, green: 255, blue: 255, alpha: 1)
        return stackView
    }()
    
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.myFont(ofSize: 20)
        return label
    }()
    
    private let countryFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private let capitalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    static let cellIdentifier = "CustomCell"
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.countryFlag.image = nil
    }
    //MARK: - Configure with data
    public func configure(with country: NewCountry, image: UIImage?) {
        countryLabel.text = country.name
        capitalLabel.text = country.capital
        countryFlag.image = image
    }
    //MARK: - Setup cell UI
    private func setupUI() {
        self.backgroundColor = .backgroundColor
        self.addSubview(mainStackView)
        setupStackView()
        setupConstraints()
    }
    
    private func setupStackView() {
        mainStackView.addArrangedSubview(countryLabel)
        mainStackView.addArrangedSubview(capitalLabel)
        mainStackView.addArrangedSubview(countryFlag)
        mainStackView.setCustomSpacing(4, after: countryFlag)
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

