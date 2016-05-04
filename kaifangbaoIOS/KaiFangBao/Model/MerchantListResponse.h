//
//  MerchantListResponse.h
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseResponse.h"
#import "Merchant.h"
@interface MerchantListResponse : BaseResponse
@property (nonatomic, strong) NSArray<Merchant> *data;
@end
