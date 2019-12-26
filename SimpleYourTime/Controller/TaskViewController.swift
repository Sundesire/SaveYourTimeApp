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
    @IBOutlet var dataProvider: DataProvider!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
        tableView.backgroundColor = .clear
        let taskManager = TaskManager()
        dataProvider.taskManager = taskManager
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startPresentation()
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
        self.title = "Задачи дня"
        navigationController?.navigationItem.largeTitleDisplayMode = .always

        //NavigationSearchBar
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.tintColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        //NavigationButton
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createTask))
        addButton.tintColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func createTask() {
        guard let newVC = storyboard?.instantiateViewController(withIdentifier: "newTaskViewController") as? NewTaskViewController else { return }
        navigationController?.pushViewController(newVC, animated: true)
    }
}
extension TaskViewController {
    func startPresentation() {
        let userDefaults = UserDefaults.standard
        let presentationWasViewed = userDefaults.bool(forKey: "PresentationWasViewed")
        if presentationWasViewed == false {
            if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "pageViewController") as? PageViewController {
                pageViewController.modalPresentationStyle = .fullScreen
                self.present(pageViewController, animated: true, completion: nil)
            }
        }
    }
}
