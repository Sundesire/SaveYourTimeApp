//
//  DataProvider.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import Foundation

class TaskManager {
    var tasks: [Task] = [Task(task: "Переделать проект", category: Category[1], dateFrom: "09:00", dateTo: "16:00")]
    
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
