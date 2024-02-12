//
//  GeographyUnitTests.swift
//  GeographyUnitTests
//
//  Created by Nikoloz Gachechiladze on 12.02.24.
//

import XCTest
@testable import Geography

class CapitalsQuizViewModelTests: XCTestCase {
    var viewModel: CapitalsQuizViewModel!
    var mockCountries: [NewCountry]!

    override func setUp() {
        super.setUp()
        viewModel = CapitalsQuizViewModel()
        mockCountries = [
            NewCountry(name: "CountryA", capital: "CapitalA", description: "DescriptionA", href: NewCountry.CountryHref(flag: "FlagURLA"), continent: "ContinentA", population: "PopulationA", currency: "CurrencyA", size: "SizeA"),
            NewCountry(name: "CountryB", capital: "CapitalB", description: "DescriptionB", href: NewCountry.CountryHref(flag: "FlagURLB"), continent: "ContinentB", population: "PopulationB", currency: "CurrencyB", size: "SizeB"),
            NewCountry(name: "CountryC", capital: "CapitalC", description: "DescriptionC", href: NewCountry.CountryHref(flag: "FlagURLC"), continent: "ContinentC", population: "PopulationC", currency: "CurrencyC", size: "SizeC"),
            NewCountry(name: "CountryD", capital: "CapitalD", description: "DescriptionD", href: NewCountry.CountryHref(flag: "FlagURLD"), continent: "ContinentD", population: "PopulationD", currency: "CurrencyD", size: "SizeD"),
            NewCountry(name: "CountryE", capital: "CapitalE", description: "DescriptionE", href: NewCountry.CountryHref(flag: "FlagURLE"), continent: "ContinentE", population: "PopulationE", currency: "CurrencyE", size: "SizeE")
        ]
        viewModel.countries = mockCountries
    }

    override func tearDown() {
        viewModel = nil
        mockCountries = nil
        super.tearDown()
    }
    
    func testReturnPossibleAnswersReturnsFourUniqueAnswers() {
        let country = mockCountries[0]
        let answers = viewModel.returnPossibleAnswers(country: country)
        XCTAssertEqual(answers.count, 4)
        XCTAssertTrue(answers.contains(country.capital))
    }
    
    func testRestartQuizResetsQuizState() {
        viewModel.restartQuiz()
        XCTAssertNotNil(viewModel.selectedCountry)
        XCTAssertEqual(viewModel.score, 0)
        XCTAssertEqual(viewModel.increment, 1)
        XCTAssertFalse(viewModel.quizCompleted)
    }
    
    func testCheckAnswerIncrementsScoreCorrectly() {
        viewModel.selectedCountry = mockCountries[0]
        let initialScore = viewModel.score
        viewModel.checkAnswer(answer: "CapitalA")
        XCTAssertEqual(viewModel.score, initialScore + 1)
    }

    func testCheckAnswerDoesNotIncrementScoreForWrongAnswer() {
        viewModel.selectedCountry = mockCountries[0]
        let initialScore = viewModel.score
        viewModel.checkAnswer(answer: "WrongAnswer")
        XCTAssertEqual(viewModel.score, initialScore)
    }

}
