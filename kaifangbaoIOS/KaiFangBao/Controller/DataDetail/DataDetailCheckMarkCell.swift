//
//  DataDetailCheckMarkCell.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/16.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class DataDetailCheckMarkCell: UITableViewCell {
    var leftText:String = ""{
        didSet{
            self.textLabel!.text = leftText
        }
    }
    let checkMark:UIImageView = UIImageView(image: UIImage(named: "ic_checkmark"))
    let selectedColor:UIColor = UIColor(hex: 0xFF3C6BD2)
    let normalColor:UIColor = UIColor.blackColor()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.opaque = true
        self.backgroundColor = UIColor.whiteColor()
        self.selectionStyle = .None
        
        self.textLabel!.font = UIFont.systemFontOfSize(15)
        self.textLabel!.textColor = self.normalColor
        
        self.checkMark.hidden = true
        self.accessoryView = self.checkMark
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.checkMark.hidden = false
            self.textLabel?.textColor = self.selectedColor
        }else{
            self.checkMark.hidden = true
            self.textLabel?.textColor = self.normalColor
        }
    }
    
    class var cellIdentifier:String{
        get{
            return NSStringFromClass(self.classForCoder())
        }
    }
    class func cellHeight() -> CGFloat{
        return 44.5
    }
}