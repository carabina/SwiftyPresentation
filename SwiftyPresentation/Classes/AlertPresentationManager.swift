//
//  AlertPresentationManager.swift
//  Presentation
//
//  Created by Nicolas Renaud on 18/05/2017.
//  Copyright © 2017 NRC. All rights reserved.
//

import UIKit

public enum AnimationDirection {
    case top
    case bottom
}

public class AlertPresentationManager: NSObject {
    
    public var presentationDirection = AnimationDirection.top
    public var dismissDirection = AnimationDirection.bottom
}

extension AlertPresentationManager: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationController = AlertPresentationController(presentedViewController: presented,
                                                                 presenting: presenting,
                                                                 presentationDirection: self.presentationDirection,
                                                                 dismissDirection: self.dismissDirection)
        return presentationController
    }
    
    public func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AlertPresentationAnimator(isPresenting: true,
                                         presentationDirection: self.presentationDirection,
                                         dismissDirection: self.dismissDirection)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AlertPresentationAnimator(isPresenting: false,
                                         presentationDirection: self.presentationDirection,
                                         dismissDirection: self.dismissDirection)
    }
}
