//
//  BaseTableViewCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/15.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    private let separatorView:UIView = KFBUtility.separatorView()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.opaque = true
        self.backgroundColor = UIColor.whiteColor()
        self.selectionStyle = .None
        
        //hide system separator
        self.separatorInset = UIEdgeInsetsZero
        if #available(iOS 8.0, *) {
            self.layoutMargins = UIEdgeInsetsZero
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 8.0, *) {
            self.preservesSuperviewLayoutMargins = false
        } else {
            // Fallback on earlier versions
        }
        
        //add custom separator
        self.contentView.addSubview(self.separatorView)
        self.separatorView.snp_makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.right.bottom.equalTo(self.contentView).priority(1000)
            make.left.equalTo(self.contentView).offset(15)
        }
        self.separatorView.hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showFullSeparator(full:Bool) -> Void{
        self.separatorView.hidden = false
        if full{
            self.separatorView.snp_updateConstraints(closure: { (make) in
                make.left.equalTo(self.contentView)
            })
        }else{
            self.separatorView.snp_updateConstraints(closure: { (make) in
                make.left.equalTo(self.contentView).offset(15)
            })
        }
    }
    
    func showSeparator(show:Bool) -> Void{
        if show {
            self.separatorView.hidden = false
        }else{
            self.separatorView.hidden = true
        }
    }
    
    class func cellHeight() -> CGFloat{
        return 44.5
    }
    
    class var cellIdentifier:String{
        get{
            return NSStringFromClass(self.classForCoder())
        }
    }
}
