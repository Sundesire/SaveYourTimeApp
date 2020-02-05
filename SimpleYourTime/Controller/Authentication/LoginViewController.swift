//
//  LoginViewController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 09.01.2020.
//  Copyright © 2020 Ivan Babushkin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var authentication: AuthenticationProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-Mail", attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 0.7024923313))])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 0.7029596434))])
        authentication = Authentication()
    }

    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        authentication.authenticate(email: emailTextField.text, password: passwordTextField.text, firstName: "Foo", lastName: "Baz", state: .login) { (result) in
            switch result {
            case .sucess :
                UserDefaults.standard.set(true, forKey: "status")
                Switcher.updateRootVC()
            case .failure(let error):
                self.showAlert(with: "Ошибка", message: error.localizedDescription)
            }
        }
    }
}
