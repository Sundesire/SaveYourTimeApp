//
//  Switcher.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 30.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import Foundation
import UIKit

class Switcher {
    static func updateRootVC(){
        let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC: UIViewController?
        print(status)
        
        if status == true {
//            let taskVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "taskViewController") as? TaskViewController
//            rootVC = UINavigationController(rootViewController: taskVC!)
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarController")
        } else {
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "authViewController") as? AuthViewController
        }
        let window = UIApplication.shared.windows.first
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        let options: UIView.AnimationOptions = .transitionFlipFromLeft
        let duration: TimeInterval = 0.7
        UIView.transition(with: window!, duration: duration, options: options, animations: {}) { completed in
            
        }
    }
}
