//
//  NewTaskViewController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    var taskManager: TaskManager!

    @IBOutlet weak var taskTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
        setUpNavigationBar()
        taskTextField.tintColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        taskTextField.backgroundColor = #colorLiteral(red: 0.2345589697, green: 0.2587072849, blue: 0.2712723017, alpha: 1)
        taskTextField.textColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        taskTextField.placeholder = "Введите задачу"
    }
}
extension NewTaskViewController {
    func setUpNavigationBar() {
        //NavigationTitle

        self.title = "Новая задача"
        navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        //NavigationButton
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveTask))
        saveButton.tintColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        self.navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc func saveTask() {
        guard taskTextField.text != "" else { return }
        let taskString = taskTextField.text
        let task = Model(task: taskString!)
        self.taskManager.add(task: task)
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
