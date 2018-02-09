//
//  SearchHistoryMediator.swift
//  Mediator
//
//  Created by Vadim Bulavin on 1/29/18.
//  Copyright © 2018 Vadim Bulavin. All rights reserved.
//

import UIKit

protocol HistoryRepository {
    var history: [String] { get }
    func addSearchTerm(_ term: String)
}

protocol HistoryView {
    var isHidden: Bool { get set }
    func setHistory(_ history: [String])
}

class SearchHistoryMediator: NSObject {
    private let searchBar: UISearchBar
    private var historyView: HistoryView
    private var observasion: NSKeyValueObservation?
    private let historyRepository: HistoryRepository

    init(searchBar: UISearchBar, historyView: HistoryView, historyRepository: HistoryRepository) {
        self.searchBar = searchBar
        self.historyView = historyView
        self.historyRepository = historyRepository
        super.init()

        self.historyView.isHidden = true
        self.historyView.setHistory(historyRepository.history)

        searchBar.delegate = self
        observasion = searchBar.observe(\.text) { [weak self] (searchBar, _) in
            self?.historyView.isHidden = searchBar.text?.isEmpty ?? false
        }
    }
}

extension SearchHistoryMediator: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        historyView.isHidden = false
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        historyView.isHidden = true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        historyView.isHidden = true
        if let text = searchBar.text, !text.isEmpty {
            historyRepository.addSearchTerm(text)
            historyView.setHistory(historyRepository.history)
            searchBar.text = nil
        }
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        historyView.isHidden = true
        searchBar.resignFirstResponder()
    }
}
