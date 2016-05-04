//
//  LoginResponse.h
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseResponse.h"
#import "User.h"
@interface LoginResponse : BaseResponse
@property (nonatomic, strong) User *data;
@end
