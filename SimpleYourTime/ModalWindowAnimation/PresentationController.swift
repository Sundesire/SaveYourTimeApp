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
        let height = bounds.height / 4
        let yHeight = bounds.height
        return CGRect(x: 0, y: yHeight - height, width: bounds.width, height: height)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(presentedView!)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    var driver: TransitionDriver!
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        if completed {
            driver.direction = .dismiss
        }
    }
}
