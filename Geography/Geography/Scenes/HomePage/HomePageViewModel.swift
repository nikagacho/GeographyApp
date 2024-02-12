//
//  HomePageViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 16.01.24.
//

import Foundation
import NetworkLayerPackage

final class HomePageViewModel {
    //MARK: - Properties
    var countries: [NewCountry] = []
    weak var delegate: HomePageViewModelDelegate?
    //MARK: - Init
    init(countries: [NewCountry], delegate: HomePageViewModelDelegate? = nil) {
        self.countries = countries
        self.delegate = delegate
    }
    //MARK: - Delegate Methods
    func didTapLearnButton() {
        delegate?.navigateToLearningPage(with: countries)
    }
    
    func didTapQuizButton() {
        delegate?.navigateToQuizPage(with: countries)
    }
    
}
//MARK: - Delegate Protocol
protocol HomePageViewModelDelegate: AnyObject {
    func navigateToLearningPage(with countries: [NewCountry])
    
    func navigateToQuizPage(with countries: [NewCountry])
}
