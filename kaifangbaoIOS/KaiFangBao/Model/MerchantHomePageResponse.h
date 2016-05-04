//
//  MerchantHomePageResponse.h
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseResponse.h"
#import "MerchantHomePage.h"
@interface MerchantHomePageResponse : BaseResponse
@property (nonatomic, strong) MerchantHomePage *data;
@end
