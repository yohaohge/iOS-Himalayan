//
//  ProjectLeftRightTextCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/15.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class ProjectLeftRightTextCell: BaseProjectCell {
    private let leftLabel:UILabel = {
        let tempLabel = UILabel()
        tempLabel.opaque = true
        tempLabel.backgroundColor = UIColor.whiteColor()
        tempLabel.textAlignment = .Left
        tempLabel.font = UIFont.systemFontOfSize(15)
        tempLabel.textColor = UIColor.blackColor()
        return tempLabel
    }()
    private let rightLabel:UILabel = {
        let tempLabel = UILabel()
        tempLabel.opaque = true
        tempLabel.backgroundColor = UIColor.whiteColor()
        tempLabel.textColor = KFBUtility.selectedColor
        tempLabel.font = UIFont.sansProFontOfSize(18)
        tempLabel.textAlignment = .Right
        return tempLabel
    }()
    var leftText:String = ""{
        didSet{
            self.leftLabel.text = leftText
        }
    }
    var rightText:String = ""{
        didSet{
            self.rightLabel.attributedText = NSAttributedString(string: rightText, attributes: [NSBaselineOffsetAttributeName:-1])
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.leftLabel)
        self.contentView.addSubview(self.rightLabel)
        
        self.leftLabel.snp_makeConstraints { (make) in
            make.height.equalTo(15)
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self.contentView)
        }
        
        self.rightLabel.snp_makeConstraints { (make) in
            make.height.equalTo(18)
            make.right.equalTo(self).offset(-15)
            make.centerY.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func cellHeight() -> CGFloat{
        return 33
    }
}
