//
//  InMemoryHistoryRepositoryTests.swift
//  SearchHistoryMediatorTests
//
//  Created by Vadim Bulavin on 1/30/18.
//  Copyright © 2018 Vadim Bulavin. All rights reserved.
//

import XCTest
@testable import SearchHistoryMediator

class InMemoryHistoryRepositoryTests: XCTestCase {

	func test_init_historyIsEmpty() {
		let sut = InMemoryHistoryRepository()
		XCTAssertTrue(sut.history.isEmpty)
	}

	func test_addSearchTerm_addsMultipleTermsOrderly() {
		let sut = InMemoryHistoryRepository()

		sut.addSearchTerm("1")
		sut.addSearchTerm("2")

		XCTAssertEqual(sut.history.count, 2)
		XCTAssertEqual(sut.history.first, "1")
		XCTAssertEqual(sut.history.last, "2")
	}

	func test_addSearchTerm_doesNotAppendDuplicatedTermToHistory() {
		let sut = InMemoryHistoryRepository()

		sut.addSearchTerm("1")
		sut.addSearchTerm("1")

		XCTAssertEqual(sut.history.count, 1)
		XCTAssertEqual(sut.history.last, "1")
	}

	func test_addSearchTerm_addsEmptyTerm() {
		let sut = InMemoryHistoryRepository()

		sut.addSearchTerm("")

		XCTAssertEqual(sut.history.count, 1)
		XCTAssertEqual(sut.history.last, "")
	}
}
