//
//  CapitalsQuizViewModelTests.swift
//  Geography
//
//  Created by Nikoloz Gachechiladze on 12.02.24.
//

import XCTest

final class CapitalsQuizViewModelTests: XCTestCase {
    
    var viewModel: CapitalsQuizViewModel!
    
    override func setUpWithError() throws {
        viewModel = CapitalsQuizViewModel()
        viewModel.countries = [NewCountry(name: "CountryOne", capital: "CapitalOne", description: "", href: nil, continent: "", population: "", currency: "", size: ""),NewCountry(name: "CountryTwo", capital: "CapitalTwo", description: "", href: nil, continent: "", population: "", currency: "", size: "")]
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadFirstQuestion() {
        viewModel.loadFirstQuestion()
        XCTAssertNotNil(viewModel.selectedCountry)
        XCTAssertEqual(viewModel.increment, 1)
        XCTAssertFalse(viewModel.possibleAnswers.isEmpty)
    }
    
    func testCheckCorrectAnswer() {
        viewModel.loadFirstQuestion()
        let selectedCountry = viewModel.selectedCountry
        viewModel.checkAnswer(answer: selectedCountry?.capital ?? "")
        XCTAssertEqual(viewModel.score, 1)
    }
    
    func testCheckWrongAnswer() {
        viewModel.loadFirstQuestion()
        viewModel.checkAnswer(answer: "WrongAnswer")
        
        XCTAssertEqual(viewModel.score, 0)
    }
    
    func testRestartQuiz() {
        viewModel.restartQuiz()
        XCTAssertEqual(viewModel.score, 0)
        XCTAssertEqual(viewModel.increment, 1)
        XCTAssertFalse(viewModel.quizCompleted)
    }
}
