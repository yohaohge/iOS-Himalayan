//
//  ProjectReportDataResponse.h
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseResponse.h"
#import "ProjectReportData.h"
@interface ProjectReportDataResponse : BaseResponse
@property (nonatomic, strong) ProjectReportData *data;
@end
