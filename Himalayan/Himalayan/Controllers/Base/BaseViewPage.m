//
//  BaseViewPage.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/7.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "BaseViewPage.h"
@interface BaseViewPage ()

@end

@implementation BaseViewPage

- (UIView *)view
{
    if (!_view) {
        _view = [[UIView alloc] init];
    }
    return _view;
}
@end
