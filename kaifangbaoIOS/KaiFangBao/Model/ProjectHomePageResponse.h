//
//  ProjectHomePageResponse.h
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseResponse.h"
#import "ProjectHomePage.h"
@interface ProjectHomePageResponse : BaseResponse
@property (nonatomic, strong) ProjectHomePage *data;
@end
