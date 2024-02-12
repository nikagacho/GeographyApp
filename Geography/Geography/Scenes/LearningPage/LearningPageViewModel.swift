//
//  LearningPageViewModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 17.01.24.
//

import UIKit
import NetworkLayerPackage

final class LearningPageViewModel {
    //MARK: - Properties
    var countries: [NewCountry] = []
    var filteredCountries: [NewCountry] = []
    var networkManager = NetworkManager<Data>()
    var buttonText = "Sort"
    private var isSorted: Bool = false
    //MARK: - Image Fetch
    func fetchImage(with urlString: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        Task {
            do {
                let data = try await networkManager.fetchImageData(from: urlString)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    //MARK: - Methods
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
