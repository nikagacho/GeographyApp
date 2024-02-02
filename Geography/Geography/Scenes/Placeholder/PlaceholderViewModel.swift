//
//  PlaceholderViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 01.02.24.
//

import Foundation
import NetworkLayerPackage

class PlaceholderViewModel {
    let networkManager = NetworkManager<CountriesData>()
    var countries: [NewCountry] = []
    weak var delegate: PlaceholderDelegate?
    
    init(countries: [NewCountry]) {
        self.countries = countries
        self.fetchData()
    }
    
    func fetchData() {
        let url = "https://restfulcountries.com/api/v1/countries"
        let headers = ["Authorization": "Bearer 500|umHXWLFgGsnm3WirwgIm3GDEaOjVYgdJj5DZuGx0"]

        Task {
            do {
                let countriesFetched = try await networkManager.fetchData(from: url, headers: headers)
                await MainActor.run {
                    countries = countriesFetched.data
                    self.delegate?.didFetchData()
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }

}

protocol PlaceholderDelegate: AnyObject {
    func didFetchData()
}
