//
//  HomePageViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 16.01.24.
//

import Foundation
import NetworkLayerPackage

class HomePageViewModel {
    let networkManager = NetworkManager<CountriesData>()
    var countries: [NewCountry] = []
    weak var delegate: HomePageViewModelDelegate?
    
    func fetchData() {
        let url = "https://restfulcountries.com/api/v1/countries"
        let headers = ["Authorization": "Bearer 500|umHXWLFgGsnm3WirwgIm3GDEaOjVYgdJj5DZuGx0"]

        Task {
            do {
                let countriesFetched = try await networkManager.fetchData(from: url, headers: headers)
                await MainActor.run {
                    countries = countriesFetched.data
                }
            } catch {
                print("Error: \(error)")
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
    func navigateToLearningPage(with countries: [NewCountry])
    
    func navigateToQuizPage(with countries: [NewCountry])
}
