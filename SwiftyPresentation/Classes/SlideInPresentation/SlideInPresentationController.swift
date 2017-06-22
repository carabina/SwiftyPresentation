//
//  SlideInPresentationController.swift
//  Presentation
//
//  Created by Nicolas Renaud on 18/05/2017.
//  Copyright © 2017 NRC. All rights reserved.
//

import UIKit

class SlideInPresentationController: UIPresentationController {
    
    // MARK: - Outlets
    
    fileprivate var dimmingView: UIView!
    
    // MARK: - Properties
    
    private var direction: PresentationDirection
    private var width: CGFloat!
    private var height: CGFloat!

    // MARK: - Constructor
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: PresentationDirection) {
        self.direction = direction
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.setupDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
        self.containerView?.insertSubview(dimmingView, at: 0)
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        
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
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        switch direction {
        case .left, .right:
            return CGSize(width: self.width, height: parentSize.height)
        case .bottom, .top:
            return CGSize(width: parentSize.width, height: self.height)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController, withParentContainerSize: self.containerView!.bounds.size)
        switch direction {
        case .right:
            frame.origin.x = self.containerView!.frame.width - self.width
        case .bottom:
            frame.origin.y = self.containerView!.frame.height - self.height
        default:
            frame.origin = .zero
        }
        return frame
    }
}

// MARK: - Private

private extension SlideInPresentationController {
  
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
