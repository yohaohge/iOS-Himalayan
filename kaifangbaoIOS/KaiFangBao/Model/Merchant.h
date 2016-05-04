//
//  Merchant.h
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseModel.h"

@protocol Merchant 
@end

@interface Merchant : BaseModel
@property (nonatomic, assign) NSInteger merchantId;
@property (nonatomic, strong) NSString *merchantName;
@end
/*
 int merchantId; 合作商id
 String merchantName; 合作商名字
 */