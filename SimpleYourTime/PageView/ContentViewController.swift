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
    @IBOutlet weak var closeButton: UIButton!
    
    var label = "Baz"
    var imageFile = ""
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.isHidden = (index == 3) ? false : true
        setButton()
        setPage()
    }
    
    func setButton() {
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
        closeButton.backgroundColor = #colorLiteral(red: 0, green: 0.8588235294, blue: 0.7607843137, alpha: 1)
        closeButton.setTitle("Закрыть", for: .normal)
        closeButton.setTitleColor(#colorLiteral(red: 0.152451545, green: 0.1685512364, blue: 0.1769267023, alpha: 1), for: .normal)
    }
    
    func setPage() {
        helloLabel.text = label
//        image.image = UIImage(named: imageFile)
        image.image = #imageLiteral(resourceName: "092")
        pagging.numberOfPages = 4
        pagging.currentPage = index
    }
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "DisplayedWalkthrough")
        self.dismiss(animated: true, completion: nil)
    }
}
