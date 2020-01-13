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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStartView()
    }

    func login(email: String?, password: String?, completion: @escaping (AuthResult)-> Void) {
        
        guard Validators.isFIlled(firstName: "Foo", lastName: "Baz", email: email, password: password) else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        guard let email = email, let password = password else {
            completion(.failure(AuthError.unknownError))
            return
        }
        
        guard Validators.isSimpleEmail(email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard let _ = result else {
                completion(.failure(error!))
                return
            }
            completion(.sucess)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        login(email: emailTextField.text, password: passwordTextField.text) { (result) in
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

extension LoginViewController {
    func setUpStartView() {
        view.backgroundColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
        loginButton.backgroundColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        loginButton.setTitle("Войти", for: .normal)
        loginButton.setTitleColor(#colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1), for: .normal)
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-Mail", attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 0.7024923313))])
        emailTextField.backgroundColor = #colorLiteral(red: 0.2345589697, green: 0.2587072849, blue: 0.2712723017, alpha: 1)
        emailTextField.textColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 0.7029596434))])
        passwordTextField.backgroundColor = #colorLiteral(red: 0.2345589697, green: 0.2587072849, blue: 0.2712723017, alpha: 1)
        passwordTextField.textColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        
    }
}
