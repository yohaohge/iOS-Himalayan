//
//  HeaderView.swift
//  KaiFangBao
//
//  Created by fdd_zhangou on 16/4/12.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    
    let nameLabel = UILabel()
    let positionLabel = UILabel()
    let imageView = UIImageView()
    
 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        nameLabel.font = UIFont.systemFontOfSize(16)
        positionLabel.font = UIFont.systemFontOfSize(14)
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        
        nameLabel.textColor = UIColor.whiteColor()
        positionLabel.textColor = UIColor.whiteColor()

        self.addSubview(nameLabel)
        self.addSubview(positionLabel)
        self.addSubview(imageView)
        
        imageView.snp_makeConstraints { (make) in
            make.top.equalTo(40)
            make.centerX.equalTo(self)
            make.width.height.equalTo(100)
        }
        
        nameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(imageView.snp_bottom).offset(12)
            make.centerX.lessThanOrEqualTo(self)
        }
        
        positionLabel.snp_makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp_bottom).offset(5)
            make.centerX.lessThanOrEqualTo(self)
        }
        
        
        
    }
    
    func setHeaderView(name:String,position:String,image:UIImage)
    {
        nameLabel.text = name
        positionLabel.text = position
        imageView.image = image
    }

}
