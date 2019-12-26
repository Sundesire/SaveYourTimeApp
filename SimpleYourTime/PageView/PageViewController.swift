//
//  PageViewController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    let titleArray = ["Свободно управляй своим временем","Регулярно планируйте свой день", "Расставляйте задачи по приоритетам", "Ставьте конкретные цели и ограничивайте время их достижения"]
    let imagesArray = [""]

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let firstVC = displayViewController(atIndex: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func displayViewController(atIndex index: Int) -> ContentViewController? {
        guard index >= 0 else { return nil}
        guard index < titleArray.count else { return nil }
        
        guard let contentVC = storyboard?.instantiateViewController(withIdentifier: "contentViewController") as? ContentViewController else { return nil}
        contentVC.label = titleArray[index]
        print("contentVC label: \(contentVC.label)")

//        contentVC.imageFile = imagesArray[index]
        contentVC.index = index
        return contentVC
    }
    func dismissPresentation() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "PresentationWasViewed")
        dismiss(animated: true, completion: nil)
    }
    
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index -= 1
        return displayViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index += 1
        return displayViewController(atIndex: index)
    }

}
