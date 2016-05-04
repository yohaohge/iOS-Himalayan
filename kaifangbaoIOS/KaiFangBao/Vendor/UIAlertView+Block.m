//
//  UIAlertView+Block.m
//  FangddSalesman
//
//  Created by ysjjchh on 14-4-24.
//  Copyright (c) 2014年 ysjjchh. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

@implementation UIAlertView (Block)

- (void)showWithCompleteHandler:(IDOBlockAlertCompleteHandler)completeHandler {
    objc_setAssociatedObject(self, "completeHandler", completeHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);

    self.delegate = self;
    [self show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    IDOBlockAlertCompleteHandler handler = objc_getAssociatedObject(self, "completeHandler");

    if (handler) {
        handler(buttonIndex);
    }
}

@end
