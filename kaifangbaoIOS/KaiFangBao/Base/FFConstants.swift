//
//  FFConstants.swift
//  KaiFangBao
//
//  Created by ysjjchh on 16/3/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import Foundation

let kScreenWidth:CGFloat = UIScreen.mainScreen().bounds.size.width
let kNetworkError:String = "亲，网络不给力啊"

let kAppVersion: String = {
    let dic = NSBundle.mainBundle().infoDictionary
    let version = dic!["CFBundleVersion"] as! String
    return version
}()

let kNotificationLoginSuccess:String = "kNotificationLoginSuccess"

let kNotificationResetMerchant:String = "kNotificationResetMerchant"

let kSystemVersion:String = UIDevice.currentDevice().systemVersion

let kIsIpad:Bool = {
    return UIDevice.currentDevice().userInterfaceIdiom == .Pad
}()

let kFirAPIToken:String = "f5e670bc4bff4ce05aa69c76d016c985"
let kAppKey:String = "com.fangdd.yun"
// colors
let kBarColor:UIColor = UIColor(hex: 0x526cfd)