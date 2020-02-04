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
        self.taskTimeFrom.text = "C \(task.dateFrom)"
        self.taskTimeTo.text = "До \(task.dateTo)"
        self.backgroundColor = .clear
        self.taskTitle.textColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        self.taskCategory.textColor = #colorLiteral(red: 0.1650192738, green: 0.6711024642, blue: 0.8877368569, alpha: 1)
        self.taskTimeTo.textColor = #colorLiteral(red: 1, green: 0.3510690331, blue: 0.330260694, alpha: 1)
        self.taskTimeFrom.textColor = #colorLiteral(red: 1, green: 0.3510690331, blue: 0.330260694, alpha: 1)
        self.taskView.backgroundColor = #colorLiteral(red: 0.2352941176, green: 0.2588235294, blue: 0.2705882353, alpha: 1)
        self.taskView.layer.cornerRadius = 10
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
       super.awakeFromNib()
       //custom logic goes here
    }
}
