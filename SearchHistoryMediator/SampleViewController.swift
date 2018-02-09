//
//  SampleViewController.swift
//  Mediator
//
//  Created by Vadim Bulavin on 1/29/18.
//  Copyright © 2018 Vadim Bulavin. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {

    private(set) lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.showsCancelButton = true
        navigationItem.titleView = sb
        return sb
    }()

    private(set) lazy var mediator: SearchHistoryMediator = {
        return SearchHistoryMediator(searchBar: searchBar, historyView: historyView, historyRepository: historyRepository)
    }()

    private(set) lazy var historyView: SearchHistoryView = {
        let historyView = SearchHistoryView()
        view.addSubview(historyView)

        historyView.translatesAutoresizingMaskIntoConstraints = false

        historyView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        historyView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        historyView.heightAnchor.constraint(equalTo: historyView.widthAnchor, multiplier: 3 / 2).isActive = true
        historyView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        return historyView
    }()

    private let historyRepository: HistoryRepository

    required init(historyRepository: HistoryRepository) {
        self.historyRepository = historyRepository
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = mediator
        view.backgroundColor = .white
        searchBar.becomeFirstResponder()
    }
}

