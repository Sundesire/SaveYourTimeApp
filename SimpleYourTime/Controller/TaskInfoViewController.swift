//
//  TaskInfoViewController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 22.01.2020.
//  Copyright © 2020 Ivan Babushkin. All rights reserved.
//

import UIKit

class TaskInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        addDismissButton()
    }

    func setUpView() {
        view.backgroundColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        view.layer.cornerRadius = 15
    }
    
    private func addDismissButton() {
        let button = UIButton(type: .system)
        button.setTitle("Закрыть", for: .normal)
        button.addTarget(self, action: #selector(dismissSelf), for: .touchUpInside)
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 80),
            ])
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true)
    }
}
