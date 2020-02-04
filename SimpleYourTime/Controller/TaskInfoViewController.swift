//
//  TaskInfoViewController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 22.01.2020.
//  Copyright © 2020 Ivan Babushkin. All rights reserved.
//

import UIKit

class TaskInfoViewController: UIViewController {
    
    let taskLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.numberOfLines = 0
        label.text = "Hello World!"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Закрыть", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        button.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        setConstraints()
    }

    func setUpView() {
        view.backgroundColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        view.layer.cornerRadius = 15
        dismissButton.layer.borderWidth = 2
        dismissButton.layer.borderColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
        dismissButton.layer.cornerRadius = 20
    }
    
    func setConstraints() {
        view.addSubview(dismissButton)
        view.addSubview(taskLabel)
        
        taskLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        taskLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        taskLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        
        dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true)
    }
}
