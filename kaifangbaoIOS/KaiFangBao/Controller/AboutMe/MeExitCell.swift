//
//  MeExitCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/21.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class MeExitCell: BaseTableViewCell {
    let headerSeparatorView:UIView = KFBUtility.separatorView()
    let exitLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .Center
        label.textColor = UIColor.redColor()
        label.text = "退出当前账号"
        label.font = UIFont.systemFontOfSize(16)
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.opaque = true
        self.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(self.exitLabel)
        self.contentView.addSubview(self.headerSeparatorView)
        self.exitLabel.snp_makeConstraints { (make) in
            make.height.equalTo(16)
            make.width.lessThanOrEqualTo(self.contentView)
            make.center.equalTo(self.contentView)
        }
        
        self.headerSeparatorView.snp_makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.top.left.right.equalTo(self.contentView).priority(1000)
        }
        self.headerSeparatorView.hidden = false
        
        self.showFullSeparator(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func cellHeight() -> CGFloat{
        return 48
    }
}
