//
//  DataProvider.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import Foundation

class TaskManager {
    var tasks: [Task] = []
    
    var category = ["Дом", "Работа", "Хобби", "Отдых", "Семья", "Здоровье", "Спорт"]
    
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
