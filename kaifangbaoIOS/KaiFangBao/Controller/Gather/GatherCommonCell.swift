//
//  GatherCommonCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/19.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class GatherCommonCell: BaseTableViewCell {
    let headerSeparatorView:UIView = KFBUtility.separatorView()
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
        tempLabel.font = UIFont.sansProFontOfSize(15)
        tempLabel.textColor = UIColor.blackColor()
        tempLabel.textAlignment = .Right
        return tempLabel
    }()
    private let rightDisclosure:UIImageView = UIImageView(image: UIImage(named:"LabelDisclosure"))
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
        self.contentView.addSubview(self.rightDisclosure)
        self.contentView.addSubview(self.headerSeparatorView)
        
        self.leftLabel.snp_makeConstraints { (make) in
            make.height.equalTo(15)
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self.contentView)
        }
        
        self.rightLabel.snp_makeConstraints { (make) in
            make.height.equalTo(15)
            make.right.equalTo(self.contentView).offset(-35)
            make.centerY.equalTo(self.contentView)
        }
        
        self.rightDisclosure.snp_makeConstraints { (make) in
            make.width.height.equalTo(15)
            make.right.equalTo(self.contentView).offset(-15)
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
        return 45
    }
    
    func showHeaderSeparator(show:Bool) -> Void{
        if show {
            self.headerSeparatorView.hidden = false
        }else{
            self.headerSeparatorView.hidden = true
        }
    }
}
