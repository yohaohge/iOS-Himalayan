//
//  KFBURL.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

let kTestAddress = "http://10.0.4.104:9440/fyb/fhb"

let kServerAddress = "https://xf.fangdd.com/fyb/fhb"
//let kServerAddress = "http://10.0.41.51:9440/fyb/fhb"

struct KFBURL {
    static var SmsCodeURL:String{
        get{
            return FFMemory.sharedMemory.serverAddress+"/userCenter/smsCode"
        }
    }
    //获取短信验证码
    //method:GET mobile 手机号码
    
    static var LoginURL:String{
        get{
            return FFMemory.sharedMemory.serverAddress+"/userCenter/login"
        }
    }
    //使用短信验证码登录
    //method:GET mobile 手机号码    code 验证码
    
    static var MerchantListURL:String{
        get{
            return FFMemory.sharedMemory.serverAddress+"/userCenter/merchantList"
        }
    }
    //获取用户绑定的合作商列表
    //method:GET mobile 手机号码
    
    static var ProjectHomePage:String{
        get{
            return FFMemory.sharedMemory.serverAddress+"/project/%d/projectHomePage"
        }
    }
    //获取项目首页数据
    //method:GET houseId为楼盘id
    //date 查询日期，yyyy-MM-dd格式
    
    static var ProjectReportData:String{
        get{
            return FFMemory.sharedMemory.serverAddress+"/project/%d/projectReportData"
        }
    }
    //获取项目报表数据
    //method:GET houseId为楼盘id
    //startDate 查询开始日期，yyyy-MM-dd格式
    //endDate   查询结束日期，yyyy-MM-dd格式
    
    static var HouseList:String{
        get{
            return FFMemory.sharedMemory.serverAddress+"/merchant/%d/houseList"
        }
    }
    //获取合作商下的楼盘列表
    //method:GET merchantId为合作商id
    
    static var MerchantHomePage:String{
        get{
            return FFMemory.sharedMemory.serverAddress+"/merchant/%d/merchantHomePage"
        }
    }
    //获取合作商首页数据
    //method:GET merchantId为合作商id
    //date 查询日期，yyyy-MM-dd格式
    
    static var ProjectDataItem:String{
        get{
            return FFMemory.sharedMemory.serverAddress+"/merchant/%d/projectDataItem"
        }
    }
    //获取合作商项目汇总数据
    //method:GET merchantId为合作商id
    /*
     startDate 查询开始日期，yyyy-MM-dd格式
     endDate   查询结束日期，yyyy-MM-dd格式
     itemId    查询条目id. int类型
     0：应收团购费
     1：应收开发商款
     2：到帐团购费
     3：到账开发商款
     4：预约金额
     5：认购退款金额
     6：认购签约套数
     7：经纪人成交套数
     8：c端成交套数
     9：现场成交套数  
     10：推客成交套数  
     11：预约套数
     12：经纪人预约套数  
     13：c端预约套数  
     14：现场预约套数  
     15：推客预约套数
     16：房多多到访客户数  
     17：经纪人到访数  
     18：c端到访数  
     19：房多多报备客户数
     20：经纪人报备客户数  
     21：c端报备客户数  
     22：推客报备客户数
     */
    
    static var firToken:String{
        get{
            return FFMemory.sharedMemory.serverAddress+"/userCenter/firToken"
        }
    }
}















