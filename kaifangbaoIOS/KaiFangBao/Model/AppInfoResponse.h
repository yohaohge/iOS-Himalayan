//
//  AppInfoResponse.h
//  KaiFangBao
//
//  Created by fdd_zhangou on 16/4/27.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseResponse.h"



@interface AppInfoResponse : JSONModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *changelog;
@property (nonatomic, strong) NSString *versionShort;
@property (nonatomic, strong) NSString *build;
@property (nonatomic, strong) NSString *installUrl;
@property (nonatomic, strong) NSString *install_url;
@property (nonatomic, strong) NSString *update_url;

@end
