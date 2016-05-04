//
//  ProjectHomePage.h
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseModel.h"

@interface ProjectHomePage : BaseModel
@property (nonatomic, assign) NSInteger signNumber;
@property (nonatomic, assign) CGFloat receiveShouldGroupAtm;
@property (nonatomic, assign) CGFloat receiveAlreadyGroupAtm;
@property (nonatomic, assign) NSInteger orderNumber;
@property (nonatomic, assign) CGFloat orderMoney;
@property (nonatomic, assign) NSInteger visitCustomerNumber;
@property (nonatomic, assign) NSInteger agentVisitCustomer;
@property (nonatomic, assign) NSInteger onlineVisitCustomer;
@property (nonatomic, assign) NSInteger recordCustomerNumber;
@property (nonatomic, assign) NSInteger agentRecordCustomer;
@property (nonatomic, assign) NSInteger onlineRecordCustomer;
@property (nonatomic, assign) NSInteger pushRecordCustomer;
@end
/*
 int signNumber; 认购及签约套数
 double receiveShouldGroupAtm; 应收团购费
 double receiveAlreadyGroupAtm; 到账团购费
 int orderNumber; 预约套数
 double orderMoney; 预约金额
 int visitCustomerNumber; 房多多总到访客户数
 int agentVisitCustomer; 经纪人客户到访数
 int onlineVisitCustomer; c端客户到访数
 int recordCustomerNumber; 房多多报备客户数
 int agentRecordCustomer; 经纪人报备客户数
 int onlineRecordCustomer; c端报备客户数
 int pushRecordCustomer; 推客报备客户数
 */