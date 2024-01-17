//
//  HomePageViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 16.01.24.
//

import Foundation
import NetworkLayerPackage

class HomePageViewModel {
    let networkManager = NetworkManager<[Country]>()
    var countries: [Country] = []
    weak var delegate: HomePageViewModelDelegate?
    
     func fetchData() {
        let url = "https://restcountries.com/v3.1/all?fields=name,capital,flag"
        Task {
            let countriesFetched = try await networkManager.fetchData(from: url)
            await MainActor.run {
                countries = countriesFetched
            }
        }
    }
    
    func didTapLearnButton() {
        delegate?.navigateToLearningPage(with: countries)
    }
    
    func didTapQuizButton() {
        delegate?.navigateToQuizPage(with: countries)
    }
    
}

protocol HomePageViewModelDelegate: AnyObject {
    func navigateToLearningPage(with countries: [Country])
    
    func navigateToQuizPage(with countries: [Country])
}
