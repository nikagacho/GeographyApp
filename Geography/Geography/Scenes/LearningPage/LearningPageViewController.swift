//
//  LearningPageViewController.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 17.01.24.
//
//

import UIKit

final class LearningPageViewController: UIViewController {
    //MARK: - Properties
    var viewModel = LearningPageViewModel()
    var router: Router?
    //MARK: - UI Elements
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGray6
        return stackView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.cellIdentifier)
        return collectionView
    }()
    
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = .systemGray6
        return searchBar
    }()
    
    private lazy var sortButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: viewModel.buttonText, style: .plain, target: self, action: #selector(sortAction))
        return button
    }()
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        searchBar.delegate = self
        navigationItem.rightBarButtonItem = sortButton
    }
    //MARK: - SetupUI
    private func setupUI() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(searchBar)
        mainStackView.addArrangedSubview(collectionView)
        view.backgroundColor = .systemGray6
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
//MARK:  - CollectionView
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
            switch result {
            case .success(let image):
                if let updateCell = collectionView.cellForItem(at: indexPath) as? CustomCell {
                    updateCell.configure(with: country, image: image)
                }
            case .failure(let error):
                print("Error fetching image: \(error.localizedDescription)")
            }
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let numberOfColumns: CGFloat = 3
        let spacingBetweenCells: CGFloat = layout.minimumInteritemSpacing
        let totalSpacing = (2 * layout.sectionInset.left) + ((numberOfColumns - 1) * spacingBetweenCells)
        let width = (collectionView.bounds.width - totalSpacing) / numberOfColumns
        let height = width
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let countryDetailsVC = CountryDetailsView() // Assuming this is a view controller
        let country = viewModel.filteredCountries[indexPath.row]
        viewModel.fetchImage(with: country.href.flag) { [weak self] result in
            switch result {
            case .success(let image):
                countryDetailsVC.configure(with: country, image: image)
            case .failure(let error):
                print("Error fetching image: \(error.localizedDescription)")
                countryDetailsVC.configure(with: country, image: nil)
            }
            self?.navigationController?.pushViewController(countryDetailsVC, animated: true)
        }
    }
    
}
//MARK: - SearchBar
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
