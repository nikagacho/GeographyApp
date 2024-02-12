//
//  QuizResultModel.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 12.02.24.
//

import Foundation

//MARK: - Quiz Result, which gets saved
struct QuizResult: Codable {
    let score: Int
    let time: Int
    let date: Date
}
