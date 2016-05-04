//
//  ProjectContentSeparatedCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/15.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class ProjectContentSeparatedCell: BaseProjectCell {
    var labelContent:String = ""{
        didSet{
            let arr = labelContent.componentsSeparatedByString(",")
            for i in 0..<arr.count{
                self.contentArray[i].attributedText = NSAttributedString(string: arr[i], attributes: [NSBaselineOffsetAttributeName:-1])
            }
            if arr.count<3{
                s2.hidden = true
                self.contentArray[2].hidden = true
            }else{
                s2.hidden = false
                self.contentArray[2].hidden = false
            }
        }
    }
    let s1 = KFBUtility.separatorView()
    let s2 = KFBUtility.separatorView()
    private let contentArray:Array<UILabel> = {
        var tempArray:Array<UILabel> = Array<UILabel>()
        for i in 0..<3{
            let c = UILabel()
            c.font = UIFont.sansProFontOfSize(14)
            c.textAlignment = .Left
            c.textColor = UIColor(hex: 0xFF8F8E94)
            c.backgroundColor = UIColor.whiteColor()
            tempArray.append(c)
        }
        return tempArray
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let labelWidth = (UIScreen.mainScreen().bounds.width-51)/3
        let c0 = self.contentArray[0]
        self.contentView.addSubview(c0)
        c0.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.width.equalTo(labelWidth)
            make.height.equalTo(15)
            make.centerY.equalTo(self.contentView)
        }
        var right = c0.snp_right
        
        self.contentView.addSubview(s1)
        s1.snp_makeConstraints { (make) in
            make.width.equalTo(0.5)
            make.height.equalTo(15)
            make.left.equalTo(right)
            make.centerY.equalTo(c0)
        }
        right = s1.snp_right
        
        let c1 = self.contentArray[1]
        self.contentView.addSubview(c1)
        c1.snp_makeConstraints { (make) in
            make.left.equalTo(right).offset(10)
            make.width.height.centerY.equalTo(c0)
        }
        right = c1.snp_right
        
        self.contentView.addSubview(s2)
        s2.snp_makeConstraints { (make) in
            make.left.equalTo(right)
            make.width.height.centerY.equalTo(s1)
        }
        right = s2.snp_right
        
        let c2 = self.contentArray[2]
        self.contentView.addSubview(c2)
        c2.snp_makeConstraints { (make) in
            make.width.height.centerY.equalTo(c0)
            make.left.equalTo(right).offset(10)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override class func cellHeight() -> CGFloat{
        return 33
    }
}
