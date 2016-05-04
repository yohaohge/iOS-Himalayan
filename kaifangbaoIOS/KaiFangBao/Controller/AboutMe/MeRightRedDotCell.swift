//
//  MeRightRedDotCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/21.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class MeRightRedDotCell: MeBaseCell {
    var hideRightCountLabel:Bool = false{
        didSet{
            self.rightCountTextLabel.hidden = hideRightCountLabel
        }
    }
    var rightCountText:String = ""{
        didSet{
            let messageCount = Int(rightCountText)
            if  messageCount>99 {
                self.rightLableContainer.hidden = false
                self.rightCountTextLabel.attributedText = NSAttributedString(string: "99+", attributes: [NSBaselineOffsetAttributeName:-1])
            }else if messageCount>0 {
                self.rightLableContainer.hidden = false
                self.rightCountTextLabel.attributedText = NSAttributedString(string: rightCountText, attributes: [NSBaselineOffsetAttributeName:-1])
            }else{
                self.rightLableContainer.hidden = true
            }
        }
    }
    private let rightCountTextLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.redColor()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.font = UIFont.sansProFontOfSize(16)
        return label
    }()
    private let rightLableContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.redColor()
        view.layer.cornerRadius = 11
        view.layer.masksToBounds = true
        return view
    }()
    private let rightDisclosure:UIImageView = UIImageView(image: UIImage(named:"LabelDisclosure"))
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.rightLableContainer)
        self.rightLableContainer.addSubview(self.rightCountTextLabel)
        self.contentView.addSubview(self.rightDisclosure)
        
        self.rightLableContainer.snp_makeConstraints { (make) in
            make.height.equalTo(22)
            make.width.greaterThanOrEqualTo(22)
            make.right.equalTo(self.contentView).offset(-35)
            make.centerY.equalTo(self.contentView)
        }
        self.rightCountTextLabel.snp_makeConstraints { (make) in
            make.center.equalTo(self.rightLableContainer)
            make.height.equalTo(16)
            make.left.equalTo(self.rightLableContainer).offset(6)
            make.right.equalTo(self.rightLableContainer).offset(-6)
        }
        
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
