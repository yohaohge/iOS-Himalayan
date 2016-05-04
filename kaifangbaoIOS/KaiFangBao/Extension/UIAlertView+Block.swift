//
//  UIAlertView+Block.swift
//  KaiFangBao
//
//  Created by ysjjchh on 16/3/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import Foundation

typealias FFAlertCompleteHandler = (Int) -> Void

extension UIAlertView {
    
    private static var key = "completeHandler".cStringUsingEncoding(NSUTF8StringEncoding)!
    
    func showWithFFAlertCompleteHandler(completeHandler: FFAlertCompleteHandler!) {
        
        objc_setAssociatedObject(self, UIAlertView.key,
                                 BlockContainer(block: completeHandler),
                                 .OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.delegate = self
        self.show()
    }
    
    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex:Int) {
        if let container = objc_getAssociatedObject(self, UIAlertView.key) as? BlockContainer<FFAlertCompleteHandler> {
            if let handler = container.block {
                handler(buttonIndex)
            }
        }
    }
}