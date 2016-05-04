//
//  User.h
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseModel.h"
#import "Merchant.h"
@interface User : BaseModel
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSArray<Merchant> *merchants;
@end
/*
 String mobile; 用户手机号
 String userName; 用户名
 String token; token信息
 List<Merchant > merchants; 用户所绑定的合作商
*/