//
//  MeRightIndicatorCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/21.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class MeRightIndicatorCell: MeBaseCell {
    private let rightDisclosure:UIImageView = UIImageView(image: UIImage(named:"LabelDisclosure"))
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.rightDisclosure)
        
        self.rightDisclosure.snp_makeConstraints { (make) in
            make.width.height.equalTo(15)
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
