//
//  BadgeView.swift
//  KaiFangBao
//
//  Created by fdd_zhangou on 16/4/12.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class BadgeView: UIImageView {
    
    let label:UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFontOfSize(15)
        lable.textColor = UIColor.whiteColor()
        lable.textAlignment = .Center
        
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.image = UIImage(named:"ic_yuan")?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 11, 0, 11))
        self.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsetsMake(0, 5, 0, 5))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setText(text:String)
    {
        label.text = text
    }
    

}
