//
//  DataProvider.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import Foundation

class TaskManager {
    var tasks: [Task] = [Task(task: "Начать писать приложение", category: "Программирование", dateFrom: "С 10:00", dateTo: "До 12:00"), Task(task: "Пообедать", category: "Дом", dateFrom: "С 12:00", dateTo: "До 14:00")]
    
    var tasksCount: Int {
        return tasks.count
    }
    
    func add(task: Task) {
        if !tasks.contains(task) {
            tasks.append(task)
        }
    }
    func task(at index: Int) ->  Task{
        return tasks[index]
    }
}
