//
//  InMemoryHistoryRepository.swift
//  Mediator
//
//  Created by Vadim Bulavin on 1/30/18.
//  Copyright © 2018 Vadim Bulavin. All rights reserved.
//

import Foundation

class InMemoryHistoryRepository: HistoryRepository {
    private(set) var history: [String] = []

    func addSearchTerm(_ term: String) {
        guard !history.contains(term) else { return }
        history.append(term)
    }
}
