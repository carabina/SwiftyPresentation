//
//  SlideInPresentationManager.swift
//  Presentation
//
//  Created by Nicolas Renaud on 17/05/2017.
//  Copyright © 2017 NRC. All rights reserved.
//

import UIKit

public enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}

public class SlideInPresentationManager: NSObject {
    
    public var direction = PresentationDirection.left
}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        let presentationController = SlideInPresentationController(presentedViewController: presented,
                                                                   presenting: presenting,
                                                                   direction: direction)
        return presentationController
    }
    
    public func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(direction: direction, isPresentation: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(direction: direction, isPresentation: false)
    }
}
