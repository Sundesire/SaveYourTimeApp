//
//  ViewController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import UIKit
import Firebase

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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
        tableView.backgroundColor = .clear
        taskManager = TaskManager()
        tableView.backgroundColor = .clear
        
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
        //NavigationBar
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1))]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1))]
        
        //NavigationTitle
        let currentDate = Date()
        let date = dateFormatter.string(from: currentDate)
        self.title = date
        
        //NavigationSearchBar
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.tintColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        //NavigationButton
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createTaskTapped))
        let exitButton = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(exitFromApp))
        addButton.tintColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        exitButton.tintColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = exitButton
    }
    
    @objc func createTaskTapped() {
        guard let newVC = storyboard?.instantiateViewController(withIdentifier: "createTaskViewController") as? CreateTaskViewController else { return }
        newVC.taskManager = self.taskManager
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    @objc func exitFromApp() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "status")
            Switcher.updateRootVC()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

extension TaskViewController {
    
    func openModalWindow() {
        let child = TaskInfoViewController()
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        present(child, animated: true)
    }
}

extension TaskViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openModalWindow()
    }
}
