//
//  ProjectSectionHeaderCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/15.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class ProjectSectionHeaderCell: BaseProjectCell {
    private let titleLabel:UILabel = {
        let tempLabel = UILabel()
        tempLabel.opaque = true
        tempLabel.backgroundColor = UIColor.whiteColor()
        tempLabel.textAlignment = .Left
        tempLabel.font = UIFont.systemFontOfSize(14)
        tempLabel.textColor = UIColor(hex: 0xFFC7C7CD)
        
        return tempLabel
    }()
    var title:String = ""{
        didSet{
            self.titleLabel.text = title
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) in
            make.height.equalTo(14)
            make.left.equalTo(self.contentView).offset(15)
            make.bottom.equalTo(self.contentView).offset(-4).priority(1000)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func cellHeight() -> CGFloat{
        return 33
    }
}
