//
//  FFNavigationController.swift
//  KaiFangBao
//
//  Created by ysjjchh on 16/3/24.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import Foundation

class FFNavigationController: UINavigationController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.clearColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
                                                            NSShadowAttributeName: shadow,
                                                            NSFontAttributeName: UIFont.boldSystemFontOfSize(18)]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        self.delegate = self
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        self.interactivePopGestureRecognizer?.enabled = false
        super.pushViewController(viewController, animated: animated)
    }
    
    func navigationController(navigationController: UINavigationController,
                              didShowViewController viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 1 &&
            !viewController.navigationItem.hidesBackButton {
            self.performSelector(#selector(FFNavigationController.delayEnable),
                                 withObject: nil, afterDelay: 0.1)
        } else {
            self.interactivePopGestureRecognizer?.enabled = false
        }
    }
    //滑动到scrollview最左侧时触发NavigationController默认的返回动作
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.interactivePopGestureRecognizer == gestureRecognizer {
            if otherGestureRecognizer.view!.isKindOfClass(UIScrollView.classForCoder()) {
                 let scrollView = otherGestureRecognizer.view as! UIScrollView
                if (scrollView.contentOffset.x == 0) {
                    return true
                }
            }
        }
        return false
    }
    func delayEnable() {
        self.interactivePopGestureRecognizer?.enabled = true
    }
    
    deinit {
        print("\(self.classForCoder) dealloc")
    }
}