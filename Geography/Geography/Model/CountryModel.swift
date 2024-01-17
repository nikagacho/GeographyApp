//
//  CountryModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 16.01.24.
//

import Foundation

struct Country: Codable {
    let name: Name
    let capital: [String]
    let flag: String
}

struct Name: Codable {
    let common: String
    let official: String
}


class MockUpData {
}

