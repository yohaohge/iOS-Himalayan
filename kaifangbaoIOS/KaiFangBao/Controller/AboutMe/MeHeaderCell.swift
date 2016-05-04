//
//  MeHeaderCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/21.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class MeHeaderCell: BaseTableViewCell {
    var name:String = ""{
        didSet{
            self.nameLabel.text = name
        }
    }
//    var career:String = ""{
//        didSet{
//            
//        }
//    }
//    var avatar:String = ""{
//        didSet{
//            
//        }
//    }
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFontOfSize(16)
        label.textAlignment = .Center
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        return label
    }()
//    private let careerLabel:UILabel = {
//        let label = UILabel()
//        label.text = "万科深圳总经理"
//        label.font = UIFont.systemFontOfSize(14)
//        label.textAlignment = .Center
//        label.backgroundColor = UIColor.clearColor()
//        label.textColor = UIColor.whiteColor()
//        return label
//    }()
    private let avatarImageView:UIImageView = {
        let im = UIImageView(frame: CGRectMake(0, 0, 80, 80))
        im.image = UIImage(named:"ic_headportraits")
        im.backgroundColor = UIColor.clearColor()
        return im
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()
        
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.nameLabel)
        
        self.avatarImageView.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(10)
            make.centerX.equalTo(self.contentView)
            make.width.height.equalTo(80)
        }
        
        self.nameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.avatarImageView.snp_bottom).offset(16)
            make.centerX.equalTo(self.contentView)
            make.height.equalTo(16)
            make.width.lessThanOrEqualTo(self.contentView)
        }
        
//        self.careerLabel.snp_makeConstraints { (make) in
//            make.top.equalTo(self.nameLabel.snp_bottom).offset(4)
//            make.centerX.equalTo(self.contentView)
//            make.height.equalTo(14)
//            make.width.lessThanOrEqualTo(self.contentView)
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func cellHeight() -> CGFloat{
        return 156
    }
}
