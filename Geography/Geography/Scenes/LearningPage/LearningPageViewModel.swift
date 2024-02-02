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
    var buttonText = "Sort"
    private var isSorted: Bool = false
    
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

    
    func sortByAlphabet() {
        if isSorted == false {
            isSorted.toggle()
            filteredCountries.sort { countryOne, countryTwo in
                countryOne.name > countryTwo.name
            }
        } else {
            isSorted.toggle()
            filteredCountries.sort { countryOne, countryTwo in
                countryOne.name < countryTwo.name
            }
        }
    }
}
