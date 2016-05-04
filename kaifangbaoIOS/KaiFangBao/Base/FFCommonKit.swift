//
//  FFCommonKit.swift
//  KaiFangBao
//
//  Created by ysjjchh on 16/3/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import Foundation

func FFDialWithAlert(phoneNumber:String) {
    
    let alert = UIAlertView()
    alert.title = "拨打电话"
    alert.message = "是否致电 \(phoneNumber)"
    alert.addButtonWithTitle("否")
    alert.addButtonWithTitle("是")
    alert.showWithFFAlertCompleteHandler { (index) -> Void in
        if 1 == index {
            let dstPhone = "tel://\(phoneNumber)"
            UIApplication.sharedApplication().openURL(NSURL(string: dstPhone)!)
        }
    }
}








