//
//  MeRightVersionCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/21.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class MeRightVersionCell: MeBaseCell {
    var rightText:String = ""{
        didSet{
            self.rightTextLabel.attributedText = NSAttributedString(string: rightText, attributes: [NSBaselineOffsetAttributeName:-1])
        }
    }
    private let rightTextLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.grayColor()
        label.textAlignment = .Center
        label.font = UIFont.sansProFontOfSize(15)
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.rightTextLabel)
        
        self.rightTextLabel.snp_makeConstraints { (make) in
            make.height.equalTo(15)
            make.width.lessThanOrEqualTo(self.contentView)
            make.right.equalTo(self.contentView).offset(-15)
            make.centerY.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func cellHeight() -> CGFloat{
        return 44.5
    }
}
