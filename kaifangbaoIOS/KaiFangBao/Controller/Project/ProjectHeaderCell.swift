//
//  ProjectHeaderCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/12.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class ProjectHeaderCell: BaseProjectCell {
    let headerCalendar = KFBHeaderCalendarView(frame: CGRectMake(0,0,UIScreen.mainScreen().bounds.width,112))
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(self.headerCalendar)
        self.headerCalendar.snp_updateConstraints { (make) in
            make.edges.equalTo(self.contentView)
            make.height.equalTo(112)
        }
        self.headerCalendar.scrollToToday()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func cellHeight() -> CGFloat{
        return 112
    }
}
