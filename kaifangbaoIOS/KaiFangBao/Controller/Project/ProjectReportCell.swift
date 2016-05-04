//
//  YunyingReportCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/13.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class ProjectReportCell: BaseProjectCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(hex: 0x071b36, alpha: 0.2)
        self.textLabel?.textColor = UIColor.whiteColor()
        self.accessoryView = UIImageView(image: UIImage(named: "disclosure"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
