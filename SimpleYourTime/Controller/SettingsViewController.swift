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
    }

}
