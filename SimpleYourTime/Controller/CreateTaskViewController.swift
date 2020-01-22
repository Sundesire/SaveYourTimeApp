//
//  CreateTaskViewController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase

class CreateTaskViewController: UIViewController {
    
    var taskManager: TaskManager!
    
    @IBOutlet weak var taskTF: UITextField!
    @IBOutlet weak var categoryTF: UITextField!
    @IBOutlet weak var timeFromTF: UITextField!
    @IBOutlet weak var timeToTF: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    
    let datePicker = UIDatePicker()
    let picker = UIPickerView()
    
    var dateFrom: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
        
        setUpNavigationBar()
        startSettings()
        showDatePicker()
        showPickerView()
    }
    
    func createNotification(task: String, dateFrom: Date) {
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Напоминание!"
        content.subtitle = "Напоминание о задаче"
        content.body = "Пора выполнить задачу: \(task)"
        content.sound = UNNotificationSound.default
        content.threadIdentifier = "local-notification temp"
        content.badge = 1
        
        let date = dateFrom
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if error != nil {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func SaveButton(_ sender: UIButton) {
        let db = Firestore.firestore()
        
        guard taskTF.text != "", categoryTF.text != "", timeFromTF.text != "", timeToTF.text != "" else { return }
        guard let task = taskTF.text, let category = categoryTF.text, let timeFrom = timeFromTF.text, let timeTo = timeToTF.text else { return }
        let newTask = Task(task: task, category: category, dateFrom: timeFrom, dateTo: timeTo)
        self.taskManager.add(task: newTask)
        
        
//        db.collection("users").document(id).collection("tasks").document().setData([
//            "task": task,
//            "category": category,
//            "timeFrom": timeFrom,
//            "timeTo": timeTo
//            ]) { error in
//                if let error = error {
//                    print("Error writing document: \(error)")
//                } else {
//                    print("Document successfully written!")
//                }
//        }
        
        
        print(newTask)
        
        if notificationSwitch.isOn {
            print("Notification on")
            createNotification(task: task, dateFrom: dateFrom!)
        } else {
            print("Notification off")
        }
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension CreateTaskViewController {
    func setTextField(textField: UITextField, tintColor: UIColor, backgroundColor: UIColor, textColor: UIColor, placeholder: String) {
        textField.tintColor = tintColor
        textField.backgroundColor = backgroundColor
        textField.textColor = textColor
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 0.7023820936))])
        textField.autocapitalizationType = .sentences
    }
    
    func startSettings() {
        setTextField(textField: taskTF, tintColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1), backgroundColor: #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1), textColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1), placeholder: "Новая задача")
        setTextField(textField: categoryTF, tintColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1), backgroundColor: #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1), textColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1), placeholder: "Категория")
        setTextField(textField: timeFromTF, tintColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1), backgroundColor: #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1), textColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1), placeholder: "12:00")
        setTextField(textField: timeToTF, tintColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1), backgroundColor: #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1), textColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1), placeholder: "14:00")
        
        saveButton.backgroundColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(#colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1), for: .normal)
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
    
    func setUpNavigationBar() {
        //NavigationTitle
        self.title = "Новая задача"
        navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        
    }
    
    func setToolbar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(doneDatePicker))
        doneButton.tintColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelDatePicker))
        cancelButton.tintColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
        
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolbar.backgroundColor = #colorLiteral(red: 0, green: 0.5770314308, blue: 0.5613815371, alpha: 1)
        return toolbar
    }
}

extension CreateTaskViewController {
    func showDatePicker() {
        datePicker.datePickerMode = .time
        datePicker.backgroundColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        datePicker.tintColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
        
        timeFromTF.inputAccessoryView = setToolbar()
        timeFromTF.inputView = datePicker
        
        timeToTF.inputAccessoryView = setToolbar()
        timeToTF.inputView = datePicker
        
    }
    @objc func doneDatePicker() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "HH:mm"
        if timeFromTF.isEditing {
            timeFromTF.text = formatter.string(from: datePicker.date)
            dateFrom = datePicker.date
            self.view.endEditing(true)
        } else if timeToTF.isEditing {
            timeToTF.text = formatter.string(from: datePicker.date)
            self.view.endEditing(true)
        } else if categoryTF.isEditing {
            self.view.endEditing(true)
        }
    }
    
    
    @objc func cancelDatePicker() {
        self.view.endEditing(true)
    }
}

extension CreateTaskViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func showPickerView() {
        categoryTF.inputAccessoryView = setToolbar()
        categoryTF.inputView = picker
        picker.delegate = self
        picker.backgroundColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        picker.tintColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return taskManager.category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return taskManager.category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTF.text = taskManager.category[row]
    }
}
