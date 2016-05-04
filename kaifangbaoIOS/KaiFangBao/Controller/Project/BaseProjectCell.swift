//
//  BaseProjectCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/12.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class BaseProjectCell: BaseTableViewCell {
    override class func cellHeight() -> CGFloat{
        return 44
    }
}

class ProjectSectionFooterCell:BaseProjectCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.showFullSeparator(false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func cellHeight() -> CGFloat{
        return 10
    }
}