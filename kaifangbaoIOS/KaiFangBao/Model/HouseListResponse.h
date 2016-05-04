//
//  HouseListResponse.h
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseResponse.h"
#import "House.h"
@interface HouseListResponse : BaseResponse
@property (nonatomic, strong) NSArray<House> *data;
@end
