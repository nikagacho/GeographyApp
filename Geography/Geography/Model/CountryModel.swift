//
//  CountryModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 16.01.24.
//

import Foundation

struct CountriesData: Codable {
    let data: [NewCountry]
}

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

struct QuizResult: Codable {
    let score: Int
    let time: Int
    let date: Date
}





