//
//  DataProvider.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import Foundation
import UIKit

class DataProvider: NSObject {
    var taskManager: TaskManager?
}

extension DataProvider: UITableViewDelegate {
    
}
extension DataProvider: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let taskManager = taskManager else { return 0}
        return taskManager.tasksCount 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.reuseId, for: indexPath) as? TasksTableViewCell
        guard let taskManager = taskManager else { fatalError() }
        let task: Task
        task = taskManager.task(at: indexPath.row)
        cell?.configure(withTask: task)
        cell?.backgroundColor = .clear
        cell?.taskTitle.textColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        cell?.taskCategory.textColor = #colorLiteral(red: 0.1650192738, green: 0.6711024642, blue: 0.8877368569, alpha: 1)
        cell?.taskTimeTo.textColor = #colorLiteral(red: 1, green: 0.3510690331, blue: 0.330260694, alpha: 1)
        cell?.taskTimeFrom.textColor = #colorLiteral(red: 1, green: 0.3510690331, blue: 0.330260694, alpha: 1)
        cell?.taskView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2588235294, blue: 0.2705882353, alpha: 1)
        cell?.taskView.layer.cornerRadius = 10
        return cell!
    }
}
