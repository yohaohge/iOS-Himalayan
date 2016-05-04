//
//  UIActionSheet+Block.swift
//  KaiFangBao
//
//  Created by ysjjchh on 16/3/23.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import Foundation

extension UIActionSheet: UIActionSheetDelegate{
    private static var key = "completeHandler".cStringUsingEncoding(NSUTF8StringEncoding)!
    
    func showWithCompleteHandler(completeHandler: FFAlertCompleteHandler, inView view: UIView) {
        
        objc_setAssociatedObject(self, UIActionSheet.key,
                                 BlockContainer(block: completeHandler),
                                 .OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.delegate = self
        self.showInView(view)
    }
    
    public func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if let container = objc_getAssociatedObject(self, UIActionSheet.key) as? BlockContainer<FFAlertCompleteHandler> {
            if let handler = container.block {
                handler(buttonIndex)
            }
        }
    }
}