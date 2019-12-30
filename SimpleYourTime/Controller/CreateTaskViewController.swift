//
//  CreateTaskViewController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController {
    
    var taskManager: TaskManager!
    
    @IBOutlet weak var taskTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
//        taskManager = TaskManager()
        setUpNavigationBar()
        setTextField()
    }

}
extension CreateTaskViewController {
    func setTextField() {
        taskTF.tintColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        taskTF.backgroundColor = #colorLiteral(red: 0.2345589697, green: 0.2587072849, blue: 0.2712723017, alpha: 1)
        taskTF.textColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        taskTF.placeholder = "Введите задачу"
        taskTF.attributedPlaceholder = NSAttributedString(string: "Введите задачу", attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 1, green: 0.3510690331, blue: 0.330260694, alpha: 1))])
        taskTF.autocapitalizationType = .sentences
    }

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
        guard taskTF.text != "" else { return }
        let task = Task(task: taskTF.text!, category: "Категория", dateFrom: "С 10:00", dateTo: "До 12:00")
        self.taskManager.add(task: task)
        print(task)
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
}


