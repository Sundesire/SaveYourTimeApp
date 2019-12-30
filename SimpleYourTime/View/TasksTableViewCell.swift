//
//  TasksTableViewCell.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    static let reuseId = "TaskCell"

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskCategory: UILabel!
    @IBOutlet weak var taskTimeFrom: UILabel!
    @IBOutlet weak var taskTimeTo: UILabel!
    @IBOutlet weak var taskView: UIView!
    
    
    func configure(withTask task: Task) {
        self.taskTitle.text = task.task
        self.taskCategory.text = task.category
        self.taskTimeFrom.text = task.dateFrom
        self.taskTimeTo.text = task.dateTo
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
    }
}
