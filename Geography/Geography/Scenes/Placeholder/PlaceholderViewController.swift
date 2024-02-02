//
//  PlaceholderViewController.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 01.02.24.
//

import UIKit

class PlaceholderViewController: UIViewController {
    
    var viewModel = PlaceholderViewModel(countries: [])
    var flowNavigator: FlowNavigator?

    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
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
    
    private let loadingText: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        rotateGlobe()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
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

extension PlaceholderViewController: PlaceholderDelegate {
    func didFetchData() {
        let homepageVC = HomePageViewController()
        homepageVC.viewModel.countries = viewModel.countries
        homepageVC.flowNavigator = flowNavigator
        navigationController?.pushViewController(homepageVC, animated: true)
    }
    
    
}
