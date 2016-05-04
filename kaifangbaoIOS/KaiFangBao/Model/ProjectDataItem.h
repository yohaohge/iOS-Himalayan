//
//  ProjectDataItem.h
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseModel.h"

@protocol ProjectDataItem

@end

@interface ProjectDataItem : BaseModel
@property (nonatomic, strong) NSString *houseId;
@property (nonatomic, strong) NSString *houseName;
@property (nonatomic, assign) CGFloat itemData;
@end
/*
 String houseId; 楼盘id
 String houseName; 楼盘名字
 double itemData; 楼盘相应条目的数据
 */