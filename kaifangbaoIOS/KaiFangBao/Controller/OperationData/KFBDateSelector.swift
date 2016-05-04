//
//  KFBDateSelector.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/18.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

@objc protocol KFBDateSelectorDelegate:NSObjectProtocol {
    func didClickPrivousButton(date:NSDate) ->Void
    func didClickNextButton(date:NSDate) ->Void
    optional func didClickDayLabel(date:NSDate) -> Void
}
enum KFBDateSelectorType:Int {
    case day
    case week
    case month
}
class KFBDateSelector: UIView {
    weak var delegate:KFBDateSelectorDelegate!
    var dateSelectorType:KFBDateSelectorType
    var date:NSDate = NSDate(){
        didSet{
            var str:String!
            //设置时间格式与左右按键是否启用
            switch self.dateSelectorType {
            case .day:
                let currentDate = NSDate()
                self.rightButton.enabled = date.fs_day<NSDate().fs_day || date.fs_year<currentDate.fs_year
                str = date.fs_stringWithFormat("yyyy/MM/dd")
                break
                //需要处理隔年的问题
            case .week:
                let currentDate = NSDate()
                self.rightButton.enabled = date.fs_weekOfYear<currentDate.fs_weekOfYear || date.fs_year<currentDate.fs_year
                let firstDayOfWeek = date.fs_firstDayOfWeek.fs_stringWithFormat("MM/dd")
                let lastDayOfWeeak = date.fs_firstDayOfWeek.fs_dateByAddingDays(6).fs_stringWithFormat("MM/dd")
                //全角符号
                str = firstDayOfWeek+"－"+lastDayOfWeeak
                break
            case .month:
                let currentDate = NSDate()
                self.rightButton.enabled = date.fs_month<currentDate.fs_month || date.fs_year<currentDate.fs_year
                str = date.fs_stringWithFormat("yyyy/MM")
                break
            }
            let attStr = NSAttributedString(string: str, attributes: [NSBaselineOffsetAttributeName:-1])
            self.dateLabel.attributedText = attStr
        }
    }
    private let dateLabel:UILabel = {
        let tempLabel = UILabel()
        tempLabel.font = UIFont.sansProFontOfSize(18)
        tempLabel.textAlignment = .Center
        tempLabel.textColor = UIColor.whiteColor()
        tempLabel.backgroundColor = UIColor.clearColor()
        return tempLabel
    }()
    
    private let leftButton:UIButton = {
        let tempButton = UIButton(type: .Custom)
        tempButton.setImage(UIImage(named: "disclosureLeft"), forState: .Normal)
        return tempButton
    }()
    
    private let rightButton:UIButton = {
        let tempButton = UIButton(type: .Custom)
        tempButton.setImage(UIImage(named: "disclosure"), forState: .Normal)
        return tempButton
    }()
    
    override convenience init(frame: CGRect) {
        self.init(type:.day)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type:KFBDateSelectorType) {
        self.dateSelectorType = type
        super.init(frame: CGRectZero)
        self.addSubview(self.leftButton)
        self.leftButton.snp_makeConstraints { (make) in
            make.top.left.bottom.equalTo(self)
            make.width.equalTo(66)
        }
        self.leftButton.addTarget(self, action: #selector(self.priviousDate), forControlEvents: .TouchUpInside)
        
        self.addSubview(self.rightButton)
        self.rightButton.snp_makeConstraints { (make) in
            make.top.right.bottom.equalTo(self)
            make.width.equalTo(66)
        }
        self.rightButton.addTarget(self, action: #selector(self.nextDate), forControlEvents: .TouchUpInside)
        
        self.addSubview(self.dateLabel)
        self.dateLabel.snp_makeConstraints { (make) in
            make.width.lessThanOrEqualTo(self.snp_width)
            make.height.equalTo(18)
            make.center.equalTo(self)
        }
        
        if type == .day {
            let button = UIButton(type: .Custom)
            button.addTarget(self, action: #selector(self.clickCurrentDayLabel), forControlEvents: .TouchUpInside)
            self.addSubview(button)
            button.snp_makeConstraints(closure: { (make) in
                make.height.equalTo(self)
                make.width.equalTo(self.dateLabel)
                make.center.equalTo(self)
            })
        }
    }
    
    func priviousDate() -> Void{
        switch self.dateSelectorType {
        case .day:
            self.date = self.date.fs_dateByAddingDays(-1)
            break
        case .week:
            self.date = self.date.fs_dateByAddingWeeks(-1)
            break
        case .month:
            let tempMonth = self.date.fs_firstDayOfMonth
            self.date = tempMonth.fs_dateByAddingMonths(-1)
            break
        }
        self.delegate.didClickPrivousButton(self.date)
    }
    
    func nextDate() ->Void{
        switch self.dateSelectorType {
        case .day:
            self.date = self.date.fs_dateByAddingDays(1)
            break
        case .week:
            self.date = self.date.fs_dateByAddingWeeks(1)
            break
        case .month:
            let tempMonth = self.date.fs_firstDayOfMonth
            self.date = tempMonth.fs_dateByAddingMonths(1)
            break
        }
        self.delegate.didClickNextButton(self.date)
    }
    
    func clickCurrentDayLabel() ->Void{
        self.delegate.didClickDayLabel!(self.date)
    }
    
    func popUpDayLabel() ->Void{
        if self.dateSelectorType == .day {
            let popDown = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
            popDown.toValue = NSValue(CGPoint:CGPointMake(0.9, 0.9))
            popDown.velocity = NSValue(CGPoint:CGPointMake(2, 2))
            self.dateLabel.pop_addAnimation(popDown, forKey: "kPopDown")
            
            let popUp = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
            popUp.duration = 0.4
            popUp.toValue = NSValue(CGPoint:CGPointMake(1, 1))
            self.dateLabel.pop_addAnimation(popUp, forKey: "kPopUp")
        }
    }
}

@objc protocol KFBCustomDateSelectorDelegate:NSObjectProtocol{
    func didClickStartDate(date:NSDate) -> Void
    func didClickEndDate(date:NSDate) -> Void
}

class KFBCustomDateSelector: UIView {
    weak var delegate:KFBCustomDateSelectorDelegate!
    let leftDateLabel:UILabel = UILabel()
    let rightDateLabel:UILabel = UILabel()
    var startDate:NSDate = NSDate(){
        didSet{
            self.leftDateLabel.text = startDate.fs_stringWithFormat("yyyy-MM-dd")
        }
    }
    var endDate:NSDate = NSDate(){
        didSet{
            self.rightDateLabel.text = endDate.fs_stringWithFormat("yyyy-MM-dd")
        }
    }
    
    init(frame: CGRect, backgroundColor:UIColor, textColor:UIColor, enbaleSeparator:Bool) {
        super.init(frame: frame)
        let dateSelectBackground = self
        
        dateSelectBackground.backgroundColor = backgroundColor
        
        if enbaleSeparator {
            let separator = KFBUtility.separatorView()
            dateSelectBackground.addSubview(separator)
            separator.snp_makeConstraints { (make) in
                make.left.right.bottom.equalTo(dateSelectBackground)
                make.height.equalTo(0.5)
            }
        }
        
        let centerLabel = UILabel()
        centerLabel.textAlignment = .Center
        centerLabel.font = UIFont.sansProFontOfSize(15)
        centerLabel.textColor = textColor
        //全角符号
        centerLabel.attributedText = NSAttributedString(string: "－", attributes: [NSBaselineOffsetAttributeName:-1])
        dateSelectBackground.addSubview(centerLabel)
        centerLabel.snp_makeConstraints { (make) in
            make.width.height.equalTo(15)
            make.center.equalTo(dateSelectBackground)
        }
        
        self.leftDateLabel.textAlignment = .Right
        self.leftDateLabel.font = UIFont.sansProFontOfSize(15)
        self.leftDateLabel.textColor = textColor
        self.leftDateLabel.attributedText = NSAttributedString(string: "选择开始时间", attributes: [NSBaselineOffsetAttributeName:-1])
        dateSelectBackground.addSubview(self.leftDateLabel)
        self.leftDateLabel.snp_makeConstraints { (make) in
            make.left.equalTo(dateSelectBackground)
            make.right.equalTo(centerLabel.snp_left)
            make.height.equalTo(15)
            make.centerY.equalTo(dateSelectBackground)
        }
        let leftButton = UIButton(type: .Custom)
        leftButton.addTarget(self, action: #selector(self.clickLeftLabel), forControlEvents: .TouchUpInside)
        self.addSubview(leftButton)
        leftButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.right.equalTo(self.leftDateLabel)
        }
        
        self.rightDateLabel.textAlignment = .Left
        self.rightDateLabel.font = UIFont.sansProFontOfSize(15)
        self.rightDateLabel.textColor = textColor
        self.rightDateLabel.attributedText = NSAttributedString(string: "选择结束时间", attributes: [NSBaselineOffsetAttributeName:-1])
        dateSelectBackground.addSubview(self.rightDateLabel)
        self.rightDateLabel.snp_makeConstraints { (make) in
            make.right.equalTo(dateSelectBackground)
            make.left.equalTo(centerLabel.snp_right)
            make.height.equalTo(15)
            make.centerY.equalTo(dateSelectBackground)
        }
        let rightButton = UIButton(type: .Custom)
        rightButton.addTarget(self, action: #selector(self.clickRightLabel), forControlEvents: .TouchUpInside)
        self.addSubview(rightButton)
        rightButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.left.right.equalTo(self.rightDateLabel)
        }
    }
    func clickLeftLabel() -> Void{
        self.delegate.didClickStartDate(self.startDate)
    }
    func clickRightLabel() -> Void
    {
        self.delegate.didClickEndDate(self.endDate)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
