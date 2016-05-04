//
//  KFBHeaderCalendarCell.swift
//  KFBHeaderCalendarCell
//
//  Created by wuhongshuai on 16/4/12.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class KFBHeaderCalendarCell: UICollectionViewCell {
    var date:NSDate = NSDate(){
        didSet{
            self.dayLabel.text = "\(date.fs_day)"
            self.yearMonthLabel.text = date.fs_stringWithFormat("yyyy年MM")
        }
    }
    let dayLabel:UILabel = UILabel()
    let yearMonthLabel:UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        let superView = self.contentView
        dayLabel.textAlignment = .Center
        dayLabel.font = UIFont.sansProFontOfSize(48)
        dayLabel.textColor = UIColor.whiteColor()
        superView.addSubview(dayLabel)
        dayLabel.snp_makeConstraints { (make) in
            make.height.equalTo(48)
            make.top.equalTo(superView).offset(20)
            make.centerX.equalTo(superView)
        }
        
        yearMonthLabel.textAlignment = .Center
        yearMonthLabel.font = UIFont.sansProFontOfSize(18)
        yearMonthLabel.textColor = UIColor.whiteColor()
        superView.addSubview(yearMonthLabel)
        yearMonthLabel.snp_makeConstraints { (make) in
            make.height.equalTo(27)
            make.top.equalTo(dayLabel.snp_bottom).offset(3)
            make.centerX.equalTo(superView)
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("error occurred in creating KFBHeaderCalendarCell within init?(coder aDecoder: NSCoder)")
    }
    
}
