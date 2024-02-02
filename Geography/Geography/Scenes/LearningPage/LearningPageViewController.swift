//
//  LearningPageViewController.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 17.01.24.
//

import UIKit

class LearningPageViewController: UIViewController {
    
    var viewModel = LearningPageViewModel()
    var flowNavigator: FlowNavigator?
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.cellIdentifier)
        return collectionView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: viewModel.buttonText, style: .plain, target: self, action: #selector(sortAction))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        searchBar.delegate = self
        navigationItem.rightBarButtonItem = sortButton
    }
    
    private func setupUI() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(searchBar)
        mainStackView.addArrangedSubview(collectionView)
        view.backgroundColor = .white
        setupConstraints()
        setupCollectionView()
    }
    
    @objc private func sortAction() {
        viewModel.sortByAlphabet()
        collectionView.reloadData()
    }

    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
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
        viewModel.filteredCountries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.cellIdentifier, for: indexPath) as? CustomCell else {
            fatalError("Cannot create new cell")
        }
        
        let country = viewModel.filteredCountries[indexPath.row]
        cell.configure(with: country, image: nil)
        
        viewModel.fetchImage(with: country.href.flag) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let image = UIImage(data: data), collectionView.cellForItem(at: indexPath) as? CustomCell === cell {
                        cell.configure(with: country, image: image)
                    }
                case .failure(let error):
                    print("Error fetching image: \(error)")
                }
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pushedVC = CountryDetailsView()
        let country = viewModel.filteredCountries[indexPath.row]
        viewModel.fetchImage(with: country.href.flag) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        pushedVC.configure(with: country, image: image)
                    }
                case .failure(let error):
                    print("Error fetching image: \(error)")
                }
            }
        }
        navigationController?.pushViewController(pushedVC, animated: true)
    }
    
}

extension LearningPageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.filteredCountries = viewModel.countries
        } else {
            viewModel.filteredCountries = viewModel.countries.filter { country in
                country.name.lowercased().contains(searchText.lowercased())
            }
        }
        
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.filteredCountries = viewModel.countries
        collectionView.reloadData()
    }
}
