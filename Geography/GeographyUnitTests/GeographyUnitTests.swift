//
//  GeographyUnitTests.swift
//  GeographyUnitTests
//
//  Created by Nikoloz Gachechiladze on 12.02.24.
//

import XCTest
@testable import Geography

class MixedQuizViewModelTests: XCTestCase {
    var viewModel: MixedQuizViewModel!
    var mockCountries: [NewCountry]!
    var preferences: QuizPreferences!
    
    override func setUp() {
        super.setUp()
        preferences = QuizPreferences(includeFlags: true, includeCapitals: true, includeCurrencies: true, enableTimer: true)
        mockCountries = [
            NewCountry(name: "CountryA", capital: "CapitalA", description: "DescriptionA", href: NewCountry.CountryHref(flag: "FlagURLA"), continent: "ContinentA", population: "PopulationA", currency: "CurrencyA", size: "SizeA"),
            NewCountry(name: "CountryB", capital: "CapitalB", description: "DescriptionB", href: NewCountry.CountryHref(flag: "FlagURLB"), continent: "ContinentB", population: "PopulationB", currency: "CurrencyB", size: "SizeB"),
            NewCountry(name: "CountryC", capital: "CapitalC", description: "DescriptionC", href: NewCountry.CountryHref(flag: "FlagURLC"), continent: "ContinentC", population: "PopulationC", currency: "CurrencyC", size: "SizeC"),
            NewCountry(name: "CountryD", capital: "CapitalD", description: "DescriptionD", href: NewCountry.CountryHref(flag: "FlagURLD"), continent: "ContinentD", population: "PopulationD", currency: "CurrencyD", size: "SizeD"),
            NewCountry(name: "CountryE", capital: "CapitalE", description: "DescriptionE", href: NewCountry.CountryHref(flag: "FlagURLE"), continent: "ContinentE", population: "PopulationE", currency: "CurrencyE", size: "SizeE")
        ]
        viewModel = MixedQuizViewModel(preferences: preferences, countries: mockCountries)
    }
    
    override func tearDown() {
        viewModel = nil
        mockCountries = nil
        preferences = nil
        super.tearDown()
    }
    
    func testReturnPossibleAnswersReturnsFourUniqueAnswersForCapitals() {
        viewModel.currentQuestionType = .capital
        let country = mockCountries[0]
        viewModel.selectedCountry = country
        let answers = viewModel.returnPossibleAnswers(country: country)
        XCTAssertEqual(answers.count, 4)
        XCTAssertTrue(answers.contains(country.capital))
    }
    
    func testReturnPossibleAnswersReturnsFourUniqueAnswersForFlags() {
        viewModel.currentQuestionType = .flag
        let country = mockCountries[0]
        viewModel.selectedCountry = country
        let answers = viewModel.returnPossibleAnswers(country: country)
        XCTAssertEqual(answers.count, 4)
        XCTAssertTrue(answers.contains(country.href.flag))
    }
    
    func testReturnPossibleAnswersReturnsFourUniqueAnswersForCurrencies() {
        viewModel.currentQuestionType = .currency
        let country = mockCountries[0]
        viewModel.selectedCountry = country
        let answers = viewModel.returnPossibleAnswers(country: country)
        XCTAssertEqual(answers.count, 4)
        XCTAssertTrue(answers.contains(country.currency ?? ""))
    }
    
    func testRestartQuizResetsQuizState() {
        viewModel.restartQuiz()
        XCTAssertNotNil(viewModel.selectedCountry)
        XCTAssertEqual(viewModel.score, 0)
        XCTAssertEqual(viewModel.increment, 1)
        XCTAssertFalse(viewModel.quizCompleted)
        XCTAssertNotNil(viewModel.currentQuestionType)
    }
    
    func testCheckAnswerIncrementsScoreCorrectlyForCapital() {
        viewModel.selectedCountry = mockCountries[0]
        viewModel.currentQuestionType = .capital
        let initialScore = viewModel.score
        viewModel.checkAnswer(answer: "CapitalA")
        XCTAssertEqual(viewModel.score, initialScore + 1)
    }
    
    func testCheckAnswerIncrementsScoreCorrectlyForFlag() {
        viewModel.selectedCountry = mockCountries[0]
        viewModel.currentQuestionType = .flag
        let initialScore = viewModel.score
        viewModel.checkAnswer(answer: "FlagURLA")
        XCTAssertEqual(viewModel.score, initialScore + 1)
    }
    
    func testCheckAnswerIncrementsScoreCorrectlyForCurrency() {
        viewModel.selectedCountry = mockCountries[0]
        viewModel.currentQuestionType = .currency
        let initialScore = viewModel.score
        viewModel.checkAnswer(answer: "CurrencyA")
        XCTAssertEqual(viewModel.score, initialScore + 1)
    }
    
    func testCheckAnswerDoesNotIncrementScoreForWrongAnswer() {
        viewModel.selectedCountry = mockCountries[0]
        viewModel.currentQuestionType = .capital
        let initialScore = viewModel.score
        viewModel.checkAnswer(answer: "WrongAnswer")
        XCTAssertEqual(viewModel.score, initialScore)
    }
}
