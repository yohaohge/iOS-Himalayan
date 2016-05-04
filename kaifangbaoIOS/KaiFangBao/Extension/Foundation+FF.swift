//
//  Foundation+FF.swift
//  KaiFangBao
//
//  Created by ysjjchh on 16/3/23.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import Foundation

extension Double {
    var dispatchTime: dispatch_time_t {
        get {
            return dispatch_time(DISPATCH_TIME_NOW, Int64(self*Double(NSEC_PER_SEC)))
        }
    }
}


extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat( hex & 0x0000FF       ) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(red: UInt, green: UInt, blue: UInt, a: CGFloat = 1) {

        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0,
                  blue: CGFloat(blue)/255.0, alpha: a)
    }
}

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        let imageSize = CGSizeMake(2, 2)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, true, UIScreen.mainScreen().scale)
        color.set()
        UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height))
        let colorImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return colorImg
    }
}