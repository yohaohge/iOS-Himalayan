//
//  ProjectReportData.h
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

#import "BaseModel.h"

@interface ProjectReportData : BaseModel
@property (nonatomic, assign) NSInteger signNumber; //认购及签约套数
@property (nonatomic, assign) CGFloat receiveShouldGroupAtm; //应收团购费
@property (nonatomic, assign) CGFloat receiveAlreadyGroupAtm; //到账团购费
@property (nonatomic, assign) CGFloat receiveShouldDeveloperAtm;// 应收开发商款
@property (nonatomic, assign) CGFloat receiveAlreadyDeveloperAtm; //到账开发商款
@property (nonatomic, assign) NSInteger orderFormNumber; //预约订单
@property (nonatomic, assign) CGFloat orderMoney; //预约金额
@property (nonatomic, assign) NSInteger refundNumber; //认购退房套数
@property (nonatomic, assign) CGFloat refundMoney; //认购退款金额
@property (nonatomic, assign) NSInteger dealNumber; //总成交套数
@property (nonatomic, assign) NSInteger agentDealNumber; //纪人成交套数
@property (nonatomic, assign) NSInteger onlineDealNumber; //c端成交套数
@property (nonatomic, assign) NSInteger pushDealNumber; //推客成交套数
@property (nonatomic, assign) NSInteger sceneDealNumber; //现场成交套数
@property (nonatomic, assign) NSInteger orderNumber; //总预约套数
@property (nonatomic, assign) NSInteger agentOrderNumber; //经纪人预约套数
@property (nonatomic, assign) NSInteger onlineOrderNumber; //c端预约套数
@property (nonatomic, assign) NSInteger pushOrderNumber; //推客预约套数
@property (nonatomic, assign) NSInteger sceneOrderNumber; //现场预约套数
@property (nonatomic, assign) NSInteger visitCustomerNumber; //房多多到访客户数
@property (nonatomic, assign) NSInteger agentVisitCustomer; //经纪人到访数
@property (nonatomic, assign) NSInteger onlineVisitCustomer; //c端到访数
@property (nonatomic, assign) NSInteger recordCustomerNumber; //房多多报备客户数
@property (nonatomic, assign) NSInteger agentRecordCustomer; //经纪人报备数
@property (nonatomic, assign) NSInteger onlineRecordCustomer; //c端报备数
@property (nonatomic, assign) NSInteger pushRecordCustomer; //推客报备数
@end
/*
 int signNumber; 认购及签约套数
 double receiveShouldGroupAtm; 应收团购费
 double receiveAlreadyGroupAtm; 到账团购费
 double receiveShouldDeveloperAtm; 应收开发商款
 double receiveAlreadyDeveloperAtm; 到账开发商款
 int orderFormNumber; 预约订单
 double orderMoney; 预约金额
 int refundNumber; 认购退房套数
 double refundMoney; 认购退款金额
 int dealNumber; 总成交套数
 int agentDealNumber; 纪人成交套数
 int onlineDealNumber; c端成交套数
 int pushDealNumber; 推客成交套数
 int sceneDealNumber; 现场成交套数
 int orderNumber; 总预约套数
 int agentOrderNumber; 经纪人预约套数
 int onlineOrderNumber; c端预约套数
 int pushOrderNumber; 推客预约套数
 int sceneOrderNumber; 现场预约套数
 int visitCustomerNumber; 房多多到访客户数
 int agentVisitCustomer; 经纪人到访数
 int onlineVisitCustomer; c端到访数
 int recordCustomerNumber; 房多多报备客户数
 int agentRecordCustomer; 经纪人报备数
 int onlineRecordCustomer; c端报备数
 int pushRecordCustomer; 推客报备数
 */