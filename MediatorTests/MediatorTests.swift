//
//  MediatorTests.swift
//  MediatorTests
//
//  Created by Vadym Bulavin on 1/29/18.
//  Copyright © 2018 Vadim Bulavin. All rights reserved.
//

import XCTest
import UIKit
@testable import Mediator

class MediatorTests: XCTestCase {

	private let historyView = HistoryViewSpy()
	private let repo = HistoryRepositoryStub()
	let searchBar = UISearchBar()
	let window = UIWindow()
	var sut: SearchHistoryMediator!

	override func setUp() {
		super.setUp()
		sut = makeSUT()
		window.addSubview(searchBar)
	}

	func test_init_hidesView_andSetsHistory() {
		repo.stubHistory(["1"])

		_ = makeSUT()

		XCTAssertTrue(historyView.isHidden)
		XCTAssertEqual(historyView.history?.first, "1")
		XCTAssertEqual(historyView.history?.count, 1)
	}

	func test_searchBar_resignFirstResponder_hidesHistory() {
		historyView.isHidden = true

		searchBar.becomeFirstResponder()

		XCTAssertFalse(historyView.isHidden)

		searchBar.resignFirstResponder()

		XCTAssertTrue(historyView.isHidden)
	}

	func test_searchBar_shouldBeginEditing() {
		XCTAssertTrue(searchBar.canBecomeFirstResponder)
	}

	func test_searchBar_setSomeText_showsHistory() {
		historyView.isHidden = true

		searchBar.text = "1"
		XCTAssertFalse(historyView.isHidden)
	}

	func test_searchBar_setNilText_hidesHistory() {
		historyView.isHidden = false

		searchBar.text = nil

		XCTAssertTrue(historyView.isHidden)
	}

	func test_searchBar_setEmptyText_hidesHistory() {
		historyView.isHidden = false

		searchBar.text = ""

		XCTAssertTrue(historyView.isHidden)
	}

	func test_searchBar_canResignFirstResponder_defaultValue_isTrue() {
		XCTAssertTrue(searchBar.canResignFirstResponder)
	}

	func test_searchBar_searchButtonClicked_hidesHistory() {
		historyView.isHidden = false

		searchBar.delegate?.searchBarSearchButtonClicked?(searchBar)

		XCTAssertTrue(historyView.isHidden)
	}

	func test_searchBar_cancelButtonClicked_hidesHistory() {
		historyView.isHidden = false

		searchBar.delegate?.searchBarCancelButtonClicked?(searchBar)

		XCTAssertTrue(historyView.isHidden)
	}

	func test_searchBar_scopeButtonIndexChange_reloadsHistoryView() {


	}

	// MARK: Helpers

	func makeSUT() -> SearchHistoryMediator {
		let repoStub = HistoryRepositoryStub()
		window.addSubview(searchBar)
		return SearchHistoryMediator(searchBar: searchBar, historyView: historyView, historyRepository: repoStub)
	}
}

private class HistoryViewSpy: UIView, HistoryView {
	private(set) var history: [String]?

	func setHistory(_ history: [String]) {
		self.history = history
	}
}

private class HistoryRepositoryStub: HistoryRepository {
	private var _history: [String] = []

	func stubHistory(_ history: [String]) {
		_history = history
	}

	var history: [String] {
		return _history
	}
}
