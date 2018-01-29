//
//  SearchHistoryMediator.swift
//  Mediator
//
//  Created by Vadym Bulavin on 1/29/18.
//  Copyright © 2018 Vadim Bulavin. All rights reserved.
//

import UIKit

protocol HistoryRepository {
	var history: [String] { get }
}

protocol HistoryView: class {
	var isHidden: Bool { get set }
	func setHistory(_ history: [String])
}

class SearchHistoryMediator: NSObject {
	private let searchBar: UISearchBar
	private let historyView: HistoryView
	private var observasion: NSKeyValueObservation?
	private let historyRepository: HistoryRepository

	init(searchBar: UISearchBar, historyView: HistoryView, historyRepository: HistoryRepository) {
		self.searchBar = searchBar
		self.historyView = historyView
		self.historyRepository = historyRepository
		super.init()

		historyView.isHidden = true
		historyView.setHistory(historyRepository.history)

		searchBar.delegate = self
		observasion = searchBar.observe(\.text) { [weak self] (searchBar, _) in
			self?.historyView.isHidden = searchBar.text?.isEmpty ?? false
		}
	}
}

extension SearchHistoryMediator: UISearchBarDelegate {

	func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
		return true
	}

	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		historyView.isHidden = false
	}

	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		historyView.isHidden = true
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		historyView.isHidden = true
	}

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		historyView.isHidden = true
	}

//	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//	}
//
//	func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//		return true
//	}
}

//@available(iOS 2.0, *)
//optional public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool // return NO to not resign first responder
//
//@available(iOS 2.0, *)
//optional public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) // called when text ends editing
//
//@available(iOS 2.0, *)
//optional public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
//
//@available(iOS 3.0, *)
//optional public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool // called before text changes
//
////
//@available(iOS 2.0, *)
//optional public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) // called when bookmark button pressed
//
//func searchBarResultsListButtonClicked(_ searchBar: UISearchBar)
//
//func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)
