//
//  ClientSwift.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/23.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit
class ClientSwift: NSObject, NSCoding {
    let osType:String
    let osVersion:String
    let pgVersion:String
    let deviceName:String
    let ipAddr:String
    var sessionToken:String
    var userName:String
    var mobile:String
    override init() {
        osType = "1"
        osVersion = UIDevice.currentDevice().systemVersion
        pgVersion = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
        deviceName = UIDevice.currentDevice().name
        ipAddr = FSUtility.getIPAddress()
        if FFMemory.sharedMemory.isLogin{
            sessionToken = FFMemory.sharedMemory.client!.sessionToken
            userName = FFMemory.sharedMemory.client!.userName
            mobile = FFMemory.sharedMemory.client!.mobile
        }else{
            sessionToken = ""
            userName = ""
            mobile = ""
        }
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        osType = aDecoder.decodeObjectForKey("osType") as! String
        osVersion = aDecoder.decodeObjectForKey("osVersion") as! String
        pgVersion = aDecoder.decodeObjectForKey("pgVersion") as! String
        deviceName = aDecoder.decodeObjectForKey("deviceName") as! String
        ipAddr = aDecoder.decodeObjectForKey("ipAddr") as! String
        sessionToken = aDecoder.decodeObjectForKey("sessionToken") as! String
        userName = aDecoder.decodeObjectForKey("userName") as! String
        mobile = aDecoder.decodeObjectForKey("mobile") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(osType, forKey: "osType")
        aCoder.encodeObject(osVersion, forKey: "osVersion")
        aCoder.encodeObject(pgVersion, forKey: "pgVersion")
        aCoder.encodeObject(deviceName, forKey: "deviceName")
        aCoder.encodeObject(ipAddr, forKey: "ipAddr")
        aCoder.encodeObject(sessionToken, forKey: "sessionToken")
        aCoder.encodeObject(userName, forKey: "userName")
        aCoder.encodeObject(mobile, forKey: "mobile")
    }
    
    func UserAgetStringSwift() -> String{
        let str = "{\"osType\":\"\(osType)\",\"osVersion\":\"\(osVersion)\",\"pgVersion\":\"\(pgVersion)\",\"deviceName\":\"\(deviceName)\",\"ipAddr\":\"\(ipAddr)\",\"sessionToken\":\"\(sessionToken)\",\"userName\":\"\(userName)\",\"mobile\":\"\(mobile)\"}"
        return str.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
    }
    override var description: String{
        get{
            let str = "{\"osType\":\"\(osType)\",\"osVersion\":\"\(osVersion)\",\"pgVersion\":\"\(pgVersion)\",\"deviceName\":\"\(deviceName)\",\"ipAddr\":\"\(ipAddr)\",\"sessionToken\":\"\(sessionToken)\",\"userName\":\"\(userName)\",\"mobile\":\"\(mobile)\"}"
            return str
        }
    }
}
