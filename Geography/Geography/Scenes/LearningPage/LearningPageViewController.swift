//
//  LearningPageViewController.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 17.01.24.
//

import UIKit

class LearningPageViewController: UIViewController {
    
    var viewModel = LearningPageViewModel()
    
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.cellIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(collectionView)
        view.backgroundColor = .white
        setupConstraints()
        setupCollectionView()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension LearningPageViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.countries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.cellIdentifier, for: indexPath) as? CustomCell else {
            fatalError()
        }
        
        cell.configure(with: viewModel.countries[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 100)
    }
    
}
