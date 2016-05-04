//
//  MeBaseCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/21.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class MeBaseCell: BaseTableViewCell {
    let headerSeparatorView:UIView = KFBUtility.separatorView()
    var leftText:String = ""{
        didSet{
            self.leftTextLabel.text = leftText
        }
    }
    private let leftTextLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.whiteColor()
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Left
        label.font  = UIFont.systemFontOfSize(15)
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.opaque = true
        self.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(self.leftTextLabel)
        self.contentView.addSubview(self.headerSeparatorView)
        self.leftTextLabel.snp_makeConstraints { (make) in
            make.height.equalTo(15)
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self.contentView)
        }
        self.headerSeparatorView.snp_makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.left.top.right.equalTo(self.contentView).priority(1000)
        }
        self.headerSeparatorView.hidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func cellHeight() -> CGFloat{
        return 44.5
    }
    func showHeaderSeparator(show:Bool) -> Void{
        if show {
            self.headerSeparatorView.hidden = false
        }else{
            self.headerSeparatorView.hidden = true
        }
    }
}
