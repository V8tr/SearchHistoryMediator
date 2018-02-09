//
//  SearchHistoryViewTests.swift
//  MediatorTests
//
//  Created by Vadim Bulavin on 1/30/18.
//  Copyright © 2018 Vadim Bulavin. All rights reserved.
//

import XCTest
@testable import SearchHistoryMediator

class SearchHistoryViewTests: XCTestCase {

    func test_setHistory_rendersHistoryChanges() {
        let sut = SearchHistoryView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        sut.setNeedsLayout()
        sut.layoutIfNeeded()

        sut.setHistory(["1", "2"])

        XCTAssertEqual(sut.tableView.numberOfSections, 1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
        XCTAssertEqual(sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.text, "1")
        XCTAssertEqual(sut.tableView.cellForRow(at: IndexPath(row: 1, section: 0))?.textLabel?.text, "2")

        sut.setHistory(["3"])

        XCTAssertEqual(sut.tableView.numberOfSections, 1)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.text, "3")
    }
}
