//
//  PresentationController.swift
//  SimpleYourTime
//
//  Created by Иван Бабушкин on 22.01.2020.
//  Copyright © 2020 Ivan Babushkin. All rights reserved.
//

import Foundation
import UIKit

class PresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
        let halfHeigh = bounds.height / 2
        return CGRect(x: 0, y: halfHeigh, width: bounds.width, height: halfHeigh)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(presentedView!)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
