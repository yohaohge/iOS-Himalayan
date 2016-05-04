//
//  UIAlertView+Block.h
//  FangddSalesman
//
//  Created by ysjjchh on 14-4-24.
//  Copyright (c) 2014年 ysjjchh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^IDOBlockAlertCompleteHandler)(NSInteger index);

@interface UIAlertView (Block)

- (void)showWithCompleteHandler:(IDOBlockAlertCompleteHandler)completeHandler;

@end
