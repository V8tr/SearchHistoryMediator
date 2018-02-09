//
//  SampleViewControllerTests.swift
//  SearchHistoryMediatorTests
//
//  Created by Vadim Bulavin on 1/30/18.
//  Copyright © 2018 Vadim Bulavin. All rights reserved.
//

import XCTest
@testable import SearchHistoryMediator

class SampleViewControllerTests: XCTestCase {

    func test_init_addsHistoryToSubview() {
        let sut = makeSUT()

        XCTAssertEqual(sut.historyView.superview, sut.view)
    }

    func test_init_focusesSearchBar_andShowsHistory() {
        let repository = InMemoryHistoryRepository()
        repository.addSearchTerm("1")

        let sut = makeSUT(repository: repository)

        XCTAssertTrue(sut.searchBar.isFirstResponder)
        XCTAssertFalse(sut.historyView.isHidden)
        XCTAssertEqual(sut.historyView.tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(sut.historyView.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.textLabel?.text, "1")
    }

    func test_init_setsHistoryFrameCorrectly_onIPhone8() {
        validateHistoryViewFrame(deviceScreenSize: CGSize(width: 375, height: 667), historyExpectedSize: CGSize(width: 375, height: 562.5))
    }

    func test_init_setsHistoryFrameCorrectly_onIPhone8Plus() {
        validateHistoryViewFrame(deviceScreenSize: CGSize(width: 414, height: 736), historyExpectedSize: CGSize(width: 414, height: 621))
    }

    func test_init_setsHistoryFrameCorrectly_onIPhoneX() {
        validateHistoryViewFrame(deviceScreenSize: CGSize(width: 375, height: 812), historyExpectedSize: CGSize(width: 375, height: 562.5))
    }

    // MARK: Helpers

    func makeSUT(repository: HistoryRepository = InMemoryHistoryRepository()) -> SampleViewController {
        let sut = SampleViewController(historyRepository: repository)
        let window = UIWindow()
        window.addSubview(sut.view)
        // View must be added to window to be able become first responder
        window.addSubview(sut.searchBar)
        return sut
    }

    func validateHistoryViewFrame(deviceScreenSize: CGSize, historyExpectedSize: CGSize) {
        let sut = SampleViewController(historyRepository: InMemoryHistoryRepository())

        sut.view.frame = CGRect(origin: .zero, size: deviceScreenSize)

        sut.view.setNeedsLayout()
        sut.view.layoutIfNeeded()

        XCTAssertEqual(sut.historyView.frame.width, historyExpectedSize.width, accuracy: 1.0)
        XCTAssertEqual(sut.historyView.frame.height, historyExpectedSize.height, accuracy: 1.0)
        XCTAssertEqual(sut.historyView.frame.origin.y, 64.0, accuracy: 1.0)
        XCTAssertEqual(sut.historyView.center.x, deviceScreenSize.width / 2, accuracy: 1.0)
    }
}
