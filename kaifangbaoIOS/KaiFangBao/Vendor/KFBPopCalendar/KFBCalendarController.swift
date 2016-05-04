//
//  CalendarController.swift
//  calendar
//
//  Created by wuhongshuai on 16/4/8.
//  Copyright © 2016年 wbuntu. All rights reserved.
//

import UIKit

protocol KFBPopCalendarControllerDelegate:NSObjectProtocol {
    func didConfirmDateSelection(date:NSDate) -> Void
}

class KFBPopCalendarController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    weak var calendarDelegate:KFBPopCalendarControllerDelegate!
    private let calendar:FSCalendar = FSCalendar()
    let backgroundView = UIView()
    private let monthLabel:UILabel = UILabel()
    private let dayLabel:UILabel = UILabel()
    private let yearLabel:UILabel = UILabel()
    private let subViewHeight = UIScreen.mainScreen().bounds.height/2
    private let enableColor:UIColor = UIColor.whiteColor()
    
    var currentDate:NSDate!
    var minimumDate:NSDate = KFBUtility.KFBMinimumDate
    var maximumDate:NSDate = NSDate()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let superView = self.view
        self.view.clipsToBounds = true
        self.view.layer.cornerRadius = 8.0
        superView.backgroundColor = UIColor.whiteColor()
        superView.addSubview(backgroundView)
        backgroundView.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(superView)
            make.height.equalTo(subViewHeight-60)
        }
        let layer = CAGradientLayer.radialGradientLayerWithSize(CGSizeMake(self.view.width, subViewHeight-60))
        backgroundView.layer.insertSublayer(layer, below: backgroundView.layer)
        
        let padding:CGFloat = 10
        let minHeight:CGFloat = (subViewHeight-90-padding*4)/5
        
        monthLabel.textAlignment = .Center
        monthLabel.font = UIFont.systemFontOfSize(minHeight)
        monthLabel.textColor = enableColor
        monthLabel.text = "\(currentDate.fs_month)"+" 月"
        backgroundView.addSubview(monthLabel)
        monthLabel.snp_makeConstraints { (make) in
            make.top.equalTo(backgroundView).offset(30)
            make.centerX.equalTo(backgroundView)
            make.height.equalTo(minHeight)
            make.width.equalTo(minHeight*6)
        }
        
        dayLabel.textAlignment = .Center
        dayLabel.font = UIFont.systemFontOfSize(minHeight*3)
        dayLabel.textColor = enableColor
        dayLabel.text = "\(currentDate.fs_day)"
        backgroundView.addSubview(dayLabel)
        dayLabel.snp_makeConstraints { (make) in
            make.top.equalTo(monthLabel.snp_bottom).offset(padding)
            make.centerX.equalTo(monthLabel)
            make.height.equalTo(minHeight*3)
            make.width.equalTo(minHeight*6)
        }
        
        yearLabel.textAlignment = .Center
        yearLabel.font = UIFont.systemFontOfSize(minHeight)
        yearLabel.textColor = enableColor
        yearLabel.text = "\(currentDate.fs_year)"
        yearLabel.userInteractionEnabled = true
        backgroundView.addSubview(yearLabel)
        yearLabel.snp_makeConstraints { (make) in
            make.top.equalTo(dayLabel.snp_bottom).offset(padding)
            make.centerX.equalTo(backgroundView)
            make.height.equalTo(minHeight)
            make.width.equalTo(minHeight*6)
        }
        
        calendar.appearance.caseOptions = [FSCalendarCaseOptions.WeekdayUsesSingleUpperCase,FSCalendarCaseOptions.HeaderUsesUpperCase]
        calendar.firstWeekday = 1
        calendar.headerDateFormat = "yyyy年M月"
        calendar.scrollDirection = .Vertical
        calendar.selectDate(self.currentDate)
        calendar.delegate = self
        calendar.dataSource = self
        calendar.todayColor = UIColor(hex: 0xF70000)
        superView.addSubview(calendar)
        calendar.snp_makeConstraints { (make) in
            make.left.right.equalTo(superView)
            make.height.equalTo(subViewHeight)
            make.top.equalTo(backgroundView.snp_bottom)
        }
        
        let confirmButton:UIButton = UIButton(type: .System)
        confirmButton.titleLabel?.font = UIFont.systemFontOfSize(18)
        confirmButton.setTitle("确定", forState: .Normal)
        confirmButton.addTarget(self, action: #selector(confirmSelection), forControlEvents: .TouchUpInside)
        superView.addSubview(confirmButton)
        confirmButton.snp_makeConstraints { (make) in
            make.height.equalTo(44)
            make.width.equalTo(84)
            make.top.equalTo(calendar.snp_bottom).offset(8)
            make.right.equalTo(superView).offset(-8)
        }
        
        let cancelButton:UIButton = UIButton(type: .System)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(18)
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.addTarget(self, action: #selector(cancelSelection), forControlEvents: .TouchUpInside)
        superView.addSubview(cancelButton)
        cancelButton.snp_makeConstraints { (make) in
            make.width.height.top.equalTo(confirmButton)
            make.right.equalTo(confirmButton.snp_left).offset(-16)
        }
    
    }
    
    func confirmSelection() -> Void {
        let currentSelectedDate = self.calendar.selectedDate
        self.dismissViewControllerAnimated(true) { 
            self.calendarDelegate.didConfirmDateSelection(currentSelectedDate)
        }
    }
    
    func cancelSelection() -> Void{
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func calendarCurrentPageDidChange(calendar: FSCalendar) {
        let date = calendar.currentPage
        monthLabel.text = "\(date.fs_month) 月"
        yearLabel.text = "\(date.fs_year)"
    }
    func maximumDateForCalendar(calendar: FSCalendar) -> NSDate {
        return self.maximumDate
    }
    
    func minimumDateForCalendar(calendar: FSCalendar) -> NSDate {
        return self.minimumDate
    }
    
    func calendar(calendar: FSCalendar, didSelectDate date: NSDate) {
        monthLabel.text = "\(date.fs_month) 月"
        dayLabel.text = "\(date.fs_day)"
        yearLabel.text = "\(date.fs_year)"
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

