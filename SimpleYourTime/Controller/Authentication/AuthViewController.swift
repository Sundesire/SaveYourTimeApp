//
//  LoginViewController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 30.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayWalkthrough()
    }
}

extension AuthViewController {
    func displayWalkthrough() {
        let userDefaults = UserDefaults.standard
        let displayedWalkthrough = userDefaults.bool(forKey: "DisplayedWalkthrough")
        if !displayedWalkthrough {
            if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "pageViewController") as? PageViewController {
                pageViewController.modalPresentationStyle = .fullScreen
                self.present(pageViewController, animated: true, completion: nil)
            }
        }
    }
}
