//
//  KFBTableViewHeaderFooterView.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/21.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class KFBTableViewHeaderFooterView: UITableViewHeaderFooterView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.font = UIFont.systemFontOfSize(14)
        self.textLabel?.frame.origin = CGPointMake(15, 16)
    }
    class func cellHeight() -> CGFloat{
        return 44
    }
}

extension UITableViewHeaderFooterView{
    class var cellIdentifier:String{
        get{
            return NSStringFromClass(self.classForCoder())
        }
    }
}