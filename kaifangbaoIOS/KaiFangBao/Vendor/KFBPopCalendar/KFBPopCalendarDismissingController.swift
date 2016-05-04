//
//  KFBPopCalendarDismissingController.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/18.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class KFBPopCalendarDismissingController: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!.view
        
        let toView = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!.view
        toView.tintAdjustmentMode = .Normal
        toView.userInteractionEnabled = true
        
        
        let closeAnimation:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPLayerPositionY)
        closeAnimation.toValue = -fromView.layer.position.y
        closeAnimation.completionBlock = {(anim,finished) in
            transitionContext.completeTransition(true)
        }
        
        let scaleDownAnimation:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleDownAnimation.springBounciness = 20
        scaleDownAnimation.toValue = NSValue(CGPoint: CGPointMake(0,0))
        
        let dismissAnimation:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPLayerOpacity)
        dismissAnimation.toValue = NSNumber(float:0)
        
        transitionContext.containerView()?.layer.pop_addAnimation(dismissAnimation, forKey: "dismissAnimation")
        fromView.layer.pop_addAnimation(closeAnimation, forKey: "closeAnimation")
        fromView.layer.pop_addAnimation(scaleDownAnimation, forKey: "scaleDown")
    }

}
