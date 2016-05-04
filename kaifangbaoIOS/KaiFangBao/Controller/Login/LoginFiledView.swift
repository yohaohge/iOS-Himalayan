//
//  LoginFiledView.swift
//  KaiFangBao
//
//  Created by fdd_zhangou on 16/4/12.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class LoginFiledView: UIView {
    
    let textFiled:UITextField = UITextField()
    let label:UILabel = UILabel()
    let seperator:UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        seperator.backgroundColor = UIColor.grayColor()
        label.textColor = UIColor.whiteColor()
        textFiled.textColor = UIColor.whiteColor()
        textFiled.clearButtonMode = .WhileEditing;

    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    func layout(){
        
        self.addSubview(textFiled)
        self.addSubview(label)
        self.addSubview(seperator)
        
        label.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
        }
        textFiled.snp_makeConstraints { (make) in
            make.left.equalTo(label.snp_right).offset(20)
            make.right.equalTo(self).priorityMedium()
            make.centerY.equalTo(self)

        }
        
        seperator.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.bottom.right.equalTo(self)
            make.height.equalTo(0.5)
        }
    }
    
    
    
}