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
    weak var delegate: LearningViewModelDelegate?
    
     func fetchData() {
        let url = "https://restcountries.com/v3.1/all?fields=name,capital,flag"
        Task {
            let countriesFetched = try await networkManager.fetchData(from: url)
            await MainActor.run {
                countries = countriesFetched
            }
        }
    }
    
    func didTapButton() {
        delegate?.navigateToLearningPage(with: countries)
    }
    
}

protocol LearningViewModelDelegate: AnyObject {
    func navigateToLearningPage(with countries: [Country])
}
