//
//  FddMemory.swift
//  KaiFangBao
//
//  Created by ysjjchh on 16/3/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import Foundation

class FFMemory: NSObject, NSCoding {
    
    var isLogin:Bool = false
    var client:ClientSwift?
    var merchant:Merchant?
    var house:House?
    var serverAddress:String = kServerAddress //不保存,默认为线上环境
    static let sharedMemory:FFMemory = {
        let path:String = FFMemory.path()
        if NSFileManager.defaultManager().fileExistsAtPath(path){
            let tempMemory:FFMemory = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! FFMemory
            return tempMemory
        }else{
            return FFMemory()
        }
    }()
    
    override init() {
        super.init()
    }
    
    private class func path() -> String {
        let document:String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        let destPath:String = document + "/user.data"
        return destPath
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(self, toFile: FFMemory.path())
    }
    
    func reset() {
        self.isLogin = false
        self.client = nil
        self.merchant = nil
        self.house = nil
        //重置时不修改serverAddress
        do {
            try NSFileManager.defaultManager().removeItemAtPath(FFMemory.path())
        } catch _ {
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.isLogin = aDecoder.decodeBoolForKey("isLogin")
        self.client = aDecoder.decodeObjectForKey("client") as? ClientSwift
        self.merchant = aDecoder.decodeObjectForKey("merchant") as? Merchant
        self.house = aDecoder.decodeObjectForKey("house") as? House
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeBool(self.isLogin, forKey: "isLogin")
        aCoder.encodeObject(self.client, forKey: "client")
        aCoder.encodeObject(self.merchant, forKey: "merchant")
        aCoder.encodeObject(self.house, forKey: "house")
    }
}













