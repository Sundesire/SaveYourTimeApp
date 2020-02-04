//
//  SettingsViewController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 29.01.2020.
//  Copyright © 2020 Ivan Babushkin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1))]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1))]
        self.title = "Настройки"
    }

}
