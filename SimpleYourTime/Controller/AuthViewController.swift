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
        setView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayWalkthrough()
    }
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        UserDefaults.standard.set(true, forKey: "status")
        Switcher.updateRootVC()
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        print(#function)
    }
}

extension AuthViewController {
    func setView() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        registerButton.layer.cornerRadius = registerButton.frame.height / 2
        
        loginButton.backgroundColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(#colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1), for: .normal)
        
        registerButton.backgroundColor = .clear
        registerButton.layer.borderWidth = 2
        registerButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        registerButton.setTitle("Регистрация", for: .normal)
        registerButton.setTitleColor(#colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1), for: .normal)
        
        view.backgroundColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
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
