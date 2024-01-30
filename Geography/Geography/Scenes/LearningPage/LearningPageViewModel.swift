//
//  LearningPageViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 17.01.24.
//

import Foundation
import NetworkLayerPackage

class LearningPageViewModel {
    var countries: [NewCountry] = []
    var filteredCountries: [NewCountry] = []
    var networkManager = NetworkManager<Data>()
    var buttonText = "Sort By Continent"
    private var isSortedByContinent: Bool = false
    
    func fetchImage(with urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        Task {
            do {
                let data = try await networkManager.fetchImageData(from: urlString)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func sortByContinent() {
        if isSortedByContinent == false {
            filteredCountries.sort { countryOne, countryTwo in
                countryOne.continent ?? "A" < countryTwo.continent ?? "A"
            }
            buttonText = "Sort By Continent"
        } else if isSortedByContinent == true {
            sortByAlphabet()
            buttonText = "Sort A-Z"
        }
        isSortedByContinent.toggle()
    }
    
    func sortByAlphabet() {
        filteredCountries.sort { countryOne, countryTwo in
            countryOne.name < countryTwo.name
        }
    }
}
