//
//  ContentViewController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 26.12.2019.
//  Copyright © 2019 Ivan Babushkin. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var pagging: UIPageControl!
    
    var label = "Baz"
    var imageFile = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }
    
    func setPage() {
        helloLabel.text = label
//        image.image = UIImage(named: imageFile)
        image.image = #imageLiteral(resourceName: "092")
        pagging.numberOfPages = 4
        pagging.currentPage = index
    }
}
