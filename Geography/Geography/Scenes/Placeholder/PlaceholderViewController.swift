//
//  PlaceholderViewController.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 01.02.24.
//

import UIKit

class PlaceholderViewController: UIViewController {
    //MARK: - Properties
    var viewModel = PlaceholderViewModel(countries: [])
    var router : Router?
    //MARK: - UI Elements
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGray6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let globeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .planet
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let loadingText: CustomLabel = {
        let label = CustomLabel(text: "Loading...", size: 40)
        label.textColor = .black
        return label
    }()
    //MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        rotateGlobe()
    }
    //MARK: - SetupUI
    private func setupUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(globeImage)
        mainStackView.addArrangedSubview(loadingText)
        viewModel.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func rotateGlobe() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 8
        rotation.repeatCount = Float.infinity
        globeImage.layer.add(rotation, forKey: "rotationAnimation")
    }
    
}
//MARK: - Delegate
extension PlaceholderViewController: PlaceholderDelegate {
    func didFetchData() {
        let homepageVC = HomePageViewController()
        homepageVC.viewModel.countries = viewModel.countries
        homepageVC.router = router
        navigationController?.pushViewController(homepageVC, animated: true)
    }
    
    
}
