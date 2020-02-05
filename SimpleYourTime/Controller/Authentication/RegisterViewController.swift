//
//  RegisterViewController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 09.01.2020.
//  Copyright © 2020 Ivan Babushkin. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var authentication: AuthenticationProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: "Имя", attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 0.7001533742))])
        lastNameTextField.attributedPlaceholder = NSAttributedString(string: "Фамилия", attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 0.7))])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-Mail", attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 0.7024923313))])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 0.7029596434))])
        //errorLabel.alpha = 0
        authentication = Authentication()
    }

    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        authentication.authenticate(email: emailTextField.text, password: passwordTextField.text, firstName: firstNameTextField.text, lastName: lastNameTextField.text, state: .register) { (result) in
            switch result {
                case .sucess:
                    UserDefaults.standard.set(true, forKey: "status")
                    Switcher.updateRootVC()
                case .failure(let error):
                    self.showAlert(with: "Ошибка", message: error.localizedDescription)
            }
        }
    }
}
