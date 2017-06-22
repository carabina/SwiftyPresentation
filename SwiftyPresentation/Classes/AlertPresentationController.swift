//
//  AlertPresentationController.swift
//  Presentation
//
//  Created by Nicolas Renaud on 18/05/2017.
//  Copyright © 2017 NRC. All rights reserved.
//

import UIKit

class AlertPresentationController: UIPresentationController {
    
    // MARK: - Outlets
    
    fileprivate var dimmingView: UIView!
    
    // MARK: - Properties
    
    private var presentationDirection: AnimationDirection
    private var dismissDirection: AnimationDirection
    private var width: CGFloat!
    private var height: CGFloat!
    
    // MARK: - Constructor
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, presentationDirection: AnimationDirection, dismissDirection: AnimationDirection) {
        self.presentationDirection = presentationDirection
        self.dismissDirection = dismissDirection
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.setupDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
        self.containerView?.insertSubview(dimmingView, at: 0)
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
                                           options: [],
                                           metrics: nil,
                                           views: ["dimmingView": dimmingView]))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
                                           options: [],
                                           metrics: nil,
                                           views: ["dimmingView": dimmingView]))
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
        self.height = (presentedView?.frame.height)!
        self.width = (presentedView?.frame.width)!
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool)  {
        if !completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin()  {
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator {
            transitionCoordinator.animate(alongsideTransition: {(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.alpha  = 0.0
            }, completion:nil)
        }
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with transitionCoordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: transitionCoordinator)
        if let containerView = containerView {
            transitionCoordinator.animate(alongsideTransition: {(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.dimmingView.frame = containerView.bounds
            }, completion:nil)
        }
    }
    
    override var frameOfPresentedViewInContainerView : CGRect {
        var frame: CGRect = .zero
        if let containerView = containerView {
            
            let width = min(containerView.bounds.size.width, self.width)
            let height = min(containerView.bounds.size.height, self.height)
            let originX = (containerView.bounds.size.width / 2) - (width / 2)
            let originY = (containerView.bounds.size.height / 2) - (height / 2)
            frame = CGRect(x: originX, y: originY, width: width, height: height)
           
            let dx = (frame.width == containerView.bounds.size.width) ? 16.0 : 0.0
            let dy = (frame.height == containerView.bounds.size.height) ? 16.0 : 0.0
            frame = frame.insetBy(dx: CGFloat(dx), dy: CGFloat(dy))
        }
        return frame
    }
}

// MARK: - Private

private extension AlertPresentationController {
    
    func setupDimmingView() {
        self.dimmingView = UIView()
        self.dimmingView.translatesAutoresizingMaskIntoConstraints = false
        self.dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        self.dimmingView.alpha = 0.0
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        self.dimmingView.addGestureRecognizer(recognizer)
    }
    
    dynamic func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
