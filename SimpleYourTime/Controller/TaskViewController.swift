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
        getTask { (task) in
            print("sucess")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func getTask(completion: @escaping (Task) -> Void) {
        let db = Firestore.firestore()
        let id = Auth.auth().currentUser?.uid
        
        db.collection("users").document(id!).collection("tasks").getDocuments {[weak self] (document, error) in
            if let error = error {
                
            } else {
                for document in document!.documents {
                    let data = document.data()
                    let task = data["task"] as! String
                    let category = data["category"] as! String
                    let dateFrom = data["timeFrom"] as! String
                    let dateTo = data["timeTo"] as! String
                    let newTask = Task(task: task, category: category, dateFrom: dateFrom, dateTo: dateTo)
                    self?.taskManager.add(task: newTask)
                    self?.taskManager.tasks.sort{ $0.dateFrom < $1.dateFrom }
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
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
    
    func openModalWindow(task: Task) {
        let child = TaskInfoViewController()
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom
        child.taskLabel.text = task.task
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
        let task = createTask(indexPath: indexPath)
        cell?.configure(withTask: task)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = createTask(indexPath: indexPath)
        openModalWindow(task: task)
    }
    
    func createTask(indexPath: IndexPath) -> Task {
        guard let taskManager = taskManager else { fatalError() }
        let task: Task
        task = taskManager.task(at: indexPath.row)
        return task
    }
}
