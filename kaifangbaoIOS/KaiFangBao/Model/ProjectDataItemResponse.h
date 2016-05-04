//
//  ProjectDataItemResponse.h
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseResponse.h"
#import "ProjectDataItem.h"
@interface ProjectDataItemResponse : BaseResponse
@property (nonatomic, strong) NSArray<ProjectDataItem> *data;
@end
