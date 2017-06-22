//
//  AlertPresentationManager.swift
//  Presentation
//
//  Created by Nicolas Renaud on 18/05/2017.
//  Copyright © 2017 NRC. All rights reserved.
//

import UIKit

enum AnimationDirection {
    case top
    case bottom
}

class AlertPresentationManager: NSObject {
    
    var presentationDirection = AnimationDirection.top
    var dismissDirection = AnimationDirection.bottom
}

extension AlertPresentationManager: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationController = AlertPresentationController(presentedViewController: presented,
                                                                 presenting: presenting,
                                                                 presentationDirection: self.presentationDirection,
                                                                 dismissDirection: self.dismissDirection)
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AlertPresentationAnimator(isPresenting: true,
                                         presentationDirection: self.presentationDirection,
                                         dismissDirection: self.dismissDirection)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AlertPresentationAnimator(isPresenting: false,
                                         presentationDirection: self.presentationDirection,
                                         dismissDirection: self.dismissDirection)
    }
}
