//
//  House.h
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseModel.h"

@protocol House
@end

@interface House : BaseModel
@property (nonatomic, strong) NSString *houseId; 
@property (nonatomic, strong) NSString *houseName;
@end
/*
 String houseId; 楼盘id
 String houseName; 楼盘名字
 */