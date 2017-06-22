//
//  AlertPresentationAnimator.swift
//  Presentation
//
//  Created by Nicolas Renaud on 18/05/2017.
//  Copyright © 2017 NRC. All rights reserved.
//

import UIKit

class AlertPresentationAnimator: NSObject {
    
    // MARK: - Properties
    
    let presentationDirection: AnimationDirection
    let dismissDirection: AnimationDirection
    let isPresenting: Bool
    let duration: TimeInterval = 0.5
    
    // MARK: - Initializers
    
    init(isPresenting: Bool, presentationDirection: AnimationDirection, dismissDirection: AnimationDirection) {
        self.isPresenting = isPresenting
        self.presentationDirection = presentationDirection
        self.dismissDirection = dismissDirection
        super.init()
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension AlertPresentationAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)  {
        if self.isPresenting {
            self.animatePresentationWithTransitionContext(transitionContext)
        }
        else {
            self.animateDismissalWithTransitionContext(transitionContext)
        }
    }
}

// MARK: - Private methods

extension AlertPresentationAnimator {
    
    func animatePresentationWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning) {
        
        if let presentedController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let presentedControllerView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
            
            presentedControllerView.frame = transitionContext.finalFrame(for: presentedController)
            if self.presentationDirection == .top {
                presentedControllerView.center.y -= transitionContext.containerView.bounds.size.height
            }
            else {
                presentedControllerView.center.y += transitionContext.containerView.bounds.size.height
            }
            transitionContext.containerView.addSubview(presentedControllerView)
            
            UIView.animate(withDuration: self.duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
                if self.presentationDirection == .top {
                    presentedControllerView.center.y += transitionContext.containerView.bounds.size.height
                }
                else {
                    presentedControllerView.center.y -= transitionContext.containerView.bounds.size.height
                }
            }, completion: {(completed: Bool) -> Void in
                transitionContext.completeTransition(completed)
            })
        }
    }
    
    func animateDismissalWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning) {
        if let presentedControllerView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
            UIView.animate(withDuration: self.duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
                if self.dismissDirection == .top {
                    presentedControllerView.center.y -= transitionContext.containerView.bounds.size.height
                }
                else {
                    presentedControllerView.center.y += transitionContext.containerView.bounds.size.height
                }
            }, completion: {(completed: Bool) -> Void in
                transitionContext.completeTransition(completed)
            })
        }
    }
}
