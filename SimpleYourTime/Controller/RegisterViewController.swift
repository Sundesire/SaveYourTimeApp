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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStartView()
        //errorLabel.alpha = 0
    }
    

    
    func register(email: String?, password: String?, completion: @escaping (AuthResult) -> Void) {
        
        guard Validators.isFIlled(firstName: firstNameTextField.text,
                                  lastName: lastNameTextField.text,
                                  email: email,
                                  password: password) else {
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
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let _ = result else {
                completion(.failure(error!))
                return
            }
            
            let db = Firestore.firestore()
            let id = Auth.auth().currentUser?.uid
            
            db.collection("users").document(id!).setData([
                "firstName": self.firstNameTextField.text!,
                "lastName": self.lastNameTextField.text!,
                "uid": result!.user.uid
            ]) { (error) in
                if error != nil {
                    completion(.failure(AuthError.serverError))
                }
                completion(.sucess)
            }
        }
        
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        register(email: emailTextField.text, password: passwordTextField.text) { (result) in
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

extension RegisterViewController {
    func setUpStartView() {
        view.backgroundColor = #colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1)
        registerButton.backgroundColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        registerButton.setTitle("Зарегестрироваться", for: .normal)
        registerButton.setTitleColor(#colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1), for: .normal)
        registerButton.layer.cornerRadius = registerButton.frame.height / 2
        
        firstNameTextField.attributedPlaceholder = NSAttributedString(string: "Имя", attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 0.7001533742))])
        firstNameTextField.autocapitalizationType = .sentences
        firstNameTextField.backgroundColor = #colorLiteral(red: 0.2345589697, green: 0.2587072849, blue: 0.2712723017, alpha: 1)
        firstNameTextField.textColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        
        
        lastNameTextField.attributedPlaceholder = NSAttributedString(string: "Фамилия", attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 0.7))])
        lastNameTextField.autocapitalizationType = .sentences
        lastNameTextField.backgroundColor = #colorLiteral(red: 0.2345589697, green: 0.2587072849, blue: 0.2712723017, alpha: 1)
        lastNameTextField.textColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: "E-Mail", attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 0.7024923313))])
        emailTextField.backgroundColor = #colorLiteral(red: 0.2345589697, green: 0.2587072849, blue: 0.2712723017, alpha: 1)
        emailTextField.textColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [.foregroundColor: UIColor.init(cgColor: #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 0.7029596434))])
        passwordTextField.backgroundColor = #colorLiteral(red: 0.2345589697, green: 0.2587072849, blue: 0.2712723017, alpha: 1)
        passwordTextField.textColor = #colorLiteral(red: 0, green: 0.8620880246, blue: 0.7615700364, alpha: 1)
    }
}
