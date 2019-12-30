//
//  Model.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import Foundation

struct Task {
    var task: String
    var category: String
    var dateFrom: String
    var dateTo: String

    init(task: String, category: String, dateFrom: String, dateTo: String) {
        self.task = task
        self.category = category
        self.dateFrom = dateFrom
        self.dateTo = dateTo
    }
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        if lhs.task == rhs.task,
        lhs.category == rhs.category {
            return true
        }
        return false
    }
}
