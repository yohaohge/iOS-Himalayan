//
//  KFBCalendarPresentingController.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/18.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class KFBPopCalendarPresentingController: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!.view
        fromView.tintAdjustmentMode = .Dimmed
        fromView.userInteractionEnabled = false
        
        let toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!.view
        let container = transitionContext.containerView()!
        
        toView.transform = CGAffineTransformMakeScale(0.9, 0.9)
        let centerP = container.center
        toView.center = CGPointMake(centerP.x, -centerP.y)
        
        container.backgroundColor = UIColor(hex: 0x00000000, alpha: 0.7)
        container.addSubview(toView)
        
        let positionAnimation:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
        positionAnimation.toValue = NSNumber(float: Float(centerP.y))
        positionAnimation.springBounciness = 10
        positionAnimation.completionBlock = {(anim,finished) in
            transitionContext.completeTransition(true)
        }
        
        let scaleAnimation:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation.springBounciness = 20
        scaleAnimation.fromValue = NSValue(CGPoint: CGPointMake(1.2,1.4))
        
        toView.layer.pop_addAnimation(positionAnimation, forKey: "positionAnimation")
        toView.layer.pop_addAnimation(scaleAnimation, forKey: "scaleAnimation")
    }
}
