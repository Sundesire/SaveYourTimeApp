//
//  DataProvider.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import Foundation

class TaskManager {
    var tasks: [Model] = []
    
    var tasksCount: Int {
        return tasks.count
    }
    
    func add(task: Model) {
        if !tasks.contains(task) {
            tasks.append(task)
        }
    }
    func task(at index: Int) ->  Model{
        return tasks[index]
    }
}
