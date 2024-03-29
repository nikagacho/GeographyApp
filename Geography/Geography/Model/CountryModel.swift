//
//  CountryModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 16.01.24.
//

import Foundation
//MARK: - Full Array - result of call
struct CountriesData: Codable {
    let data: [NewCountry]
}
//MARK: - Country Model
struct NewCountry: Codable {
    let name: String
    let capital: String
    let description: String?
    let href: CountryHref
    let continent: String?
    let population: String
    let currency: String?
    let size: String?
    
    struct CountryHref: Codable {
        let flag: String
    }
}





