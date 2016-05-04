//
//  BaseResponse.m
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse
- (BOOL)success{
    if (_code.integerValue == 10000) {
        return YES;
    }else{
        return NO;
    }
}
@end
