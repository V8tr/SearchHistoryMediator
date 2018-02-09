//
//  SeachHistoryView.swift
//  Mediator
//
//  Created by Vadim Bulavin on 1/30/18.
//  Copyright © 2018 Vadim Bulavin. All rights reserved.
//

import UIKit

class SearchHistoryView: UIView {

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.dataSource = self
        return tableView
    }()

    private var history: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        _ = tableView
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _ = tableView
    }
}

extension SearchHistoryView: HistoryView {
    func setHistory(_ history: [String]) {
        self.history = history
    }
}

extension SearchHistoryView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = history[indexPath.row]
        return cell
    }
}

