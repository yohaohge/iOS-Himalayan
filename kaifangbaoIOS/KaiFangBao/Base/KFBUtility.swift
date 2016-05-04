//
//  KFBUtility.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/12.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class KFBUtility: NSObject {
    static let commonBackgroundColor = UIColor(hex: 0xFFEFEFF4)
    static let selectedColor = UIColor(hex: 0xFF3C6BD2)
    static let KFBScreenWidth = UIScreen.mainScreen().bounds.width
    static let KFBScreenHeight = UIScreen.mainScreen().bounds.height
    static let KFBMinimumDate:NSDate = NSDate.fs_dateFromString("2011-11-11 00:00:00", format: "yyyy-MM-dd hh:mm:ss")
    class func separatorView() -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xFFC8C7CC)
        return view
    }
    class func customTitleButton() -> UIButton{
        let button = UIButton(type: .Custom)
        button.backgroundColor = UIColor.clearColor()
        button.titleLabel?.font = UIFont.systemFontOfSize(16)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setImage(UIImage(named:"DataDetailTriangle"), forState: .Normal)
        button.adjustsImageWhenHighlighted = false
        button.transform = CGAffineTransformMakeScale(-1.0, 1.0)
        button.titleLabel!.transform = CGAffineTransformMakeScale(-1.0, 1.0)
        button.imageView!.transform = CGAffineTransformMakeScale(-1.0, 1.0)
        return button
    }
    class func formatFloatValue(value:CGFloat) -> String{
        if value == 0 {
            return "0"
        }else{
            return String(format: "%.2f", value)
        }
    }
}

extension UIFont{
    class func sansProFont() -> UIFont{
        return sansProFontOfSize(17.0)
    }
    class func sansProFontOfSize(fontSize: CGFloat) -> UIFont{
        //字体baseline不为零，使用中文字体时，仍然采用系统默认字体，uilabel使用时label高度需要稍微大于字体大小,,或者下调baseline
        //self.rightLabel.attributedText = NSAttributedString(string: rightText, attributes: [NSBaselineOffsetAttributeName:-1])
        let font:UIFont = UIFont(name: "Neo Sans Pro", size: fontSize)!
        return font
    }
}

extension CALayer{
    class func radialGradientLayerWithSize(size:CGSize) -> CALayer{
        let startColor = UIColor(hex: 0x5b96fb)
        let endColor = UIColor(hex: 0x0041ae)
        
        let layer:CALayer = CALayer()
        layer.frame = CGRectMake(0, 0, size.width, size.height)
        
        let center:CGPoint = CGPointMake(size.width/2,size.height/2)
        let s = size.width*size.width + size.height*size.height
        let radius = sqrt(s/4)
        let colors = [startColor.CGColor,endColor.CGColor]
        let locations:[CGFloat] = [0,1]
        let space:CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
        let gradient:CGGradientRef = CGGradientCreateWithColors(space, colors, locations)!
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        CGContextDrawRadialGradient(ctx, gradient, center, 0.0, center, radius, CGGradientDrawingOptions.DrawsAfterEndLocation)
        layer.contents = CGBitmapContextCreateImage(ctx)
        UIGraphicsEndImageContext()
        return layer
    }
    class func linearGradientLayerWithSize(size:CGSize) -> CALayer{
        let startColor = UIColor(hex: 0x5b96fb)
        let endColor = UIColor(hex: 0x0041ae)
        
        let layer:CALayer = CALayer()
        layer.frame = CGRectMake(0, 0, size.width, size.height)
        
        let colors = [startColor.CGColor,endColor.CGColor]
        let locations:[CGFloat] = [0,1]
        let space:CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
        let gradient:CGGradientRef = CGGradientCreateWithColors(space, colors, locations)!
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        CGContextDrawLinearGradient(ctx, gradient, CGPointZero, CGPointMake(size.width, size.height), CGGradientDrawingOptions.DrawsAfterEndLocation)
        layer.contents = CGBitmapContextCreateImage(ctx)
        UIGraphicsEndImageContext()
        return layer
    }
}