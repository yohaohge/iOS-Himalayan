//
//  KFBSplashView.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/26.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class KFBSplashView: UIView {
    //直接绘制后存成LaunchImage
    func showAnimation() -> Void{
        let fade:POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        fade.toValue = NSNumber(float: Float(0))
        fade.completionBlock = {[unowned self](anim,finished) in
            if finished {
                self.removeFromSuperview()
            }
        }
        self.pop_addAnimation(fade, forKey: "kFade")
    }
    let iconImageView:UIImageView = {
        let imV = UIImageView(image: UIImage(named: "Icon-76"))
        imV.backgroundColor = UIColor.clearColor()
        imV.layer.cornerRadius = 13.5
        imV.layer.masksToBounds = true
        return imV
    }()
    let centerLabel:UILabel = {
        let label = UILabel()
        label.text = "房云宝合作商版"
        label.font = UIFont.systemFontOfSize(18)
        label.textAlignment = .Center
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        return label
    }()
    
    let bottomLabel:UILabel = {
        let label = UILabel()
        label.text = "数据随行 合作共赢"
        label.font = UIFont.systemFontOfSize(18)
        label.textAlignment = .Center
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        let layer = CALayer.radialGradientLayerWithSize(UIScreen.mainScreen().bounds.size)
        self.layer.insertSublayer(layer, atIndex: 0)
        
        self.addSubview(self.iconImageView)
        self.addSubview(self.centerLabel)
        self.addSubview(self.bottomLabel)
        
        self.iconImageView.snp_makeConstraints { (make) in
            make.width.height.equalTo(76)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp_centerY).offset(-5)
        }
        
        self.centerLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.iconImageView.snp_bottom).offset(15)
            make.height.equalTo(18)
            make.width.lessThanOrEqualTo(self)
        }
        
        self.bottomLabel.snp_makeConstraints { (make) in
            make.height.equalTo(18)
            make.width.lessThanOrEqualTo(self)
            make.bottom.equalTo(self).offset(-50)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
