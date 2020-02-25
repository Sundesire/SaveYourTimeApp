//
//  ViewController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru-RU")
        df.dateFormat = "dd MMMM"
        return df
    }
    
    var taskManager: TaskManager!
    
    
    private let transition = PanelTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .clear
        taskManager = TaskManager()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
}

extension TaskViewController {
    func setUpNavigationBar() {
        //NavigationTitle
        let currentDate = Date()
        let date = dateFormatter.string(from: currentDate)
        navigationItem.title = date

    }

}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let taskManager = taskManager else { return 0}
        return taskManager.tasksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.reuseId, for: indexPath) as? TasksTableViewCell
        let task = createTask(indexPath: indexPath)
        cell?.configure(withTask: task)
        return cell!
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let task = createTask(indexPath: indexPath)
//        openModalWindow(task: task)
//    }
    
    func createTask(indexPath: IndexPath) -> Task {
        guard let taskManager = taskManager else { fatalError() }
        let task: Task
        task = taskManager.task(at: indexPath.row)
        return task
    }
}

extension TaskViewController {
    
    func openModalWindow(task: Task) {
        let child = TaskInfoViewController()
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        child.taskLabel.text = task.task
        present(child, animated: true)
    }
}
