//
//  OperationDataController.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/15.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class OperationDataController: BaseController, UIScrollViewDelegate {
    let controllers:[OperationDataReportBaseController] = [DayReportController(),WeekReportController(),MonthReportController(),CustomReportController()]
    let labels:[UILabel] = {
        var tempArray = [UILabel]()
        let titles = ["日报","周报","月报","自定义"]
        let labelWidth = UIScreen.mainScreen().bounds.width/4
        for i in 0..<4{
            let label = UILabel(frame: CGRectMake(labelWidth*CGFloat(i),64,labelWidth,44))
            label.backgroundColor = UIColor.clearColor()
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.systemFontOfSize(18)
            label.textAlignment = .Center
            label.text = titles[i]
            label.alpha = 0.5
            tempArray.append(label)
        }
        return tempArray
    }()
    let headerSpaceHeight:CGFloat = 64+44
    let whiteSlider:UIView = {
        let view = UIView()
        view.frame = CGRectMake(0, 64+44-3, UIScreen.mainScreen().bounds.width/4, 3)
        view.backgroundColor = UIColor.whiteColor()
        return view
    }()
    var scrollView:UIScrollView!
    let pageWidth = UIScreen.mainScreen().bounds.width
    let pageHeight = UIScreen.mainScreen().bounds.height-64-44
    var currentPage:Int = 0
    var houseId:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackItem()
        let layer = CAGradientLayer.linearGradientLayerWithSize(CGSizeMake(self.view.bounds.width, headerSpaceHeight+44))
        self.view.layer.insertSublayer(layer, atIndex: 0)
        
        for label in self.labels{
            label.userInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapLabel(_:)))
            label.addGestureRecognizer(tap)
            self.view.addSubview(label)
        }
        labels[0].alpha = 1.0
        
        self.view.addSubview(self.whiteSlider)
        
        self.scrollView = UIScrollView(frame: CGRectMake(0, self.headerSpaceHeight, self.pageWidth, self.pageHeight))
        self.scrollView.contentSize = CGSizeMake(self.pageWidth*4, self.pageHeight)
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
        self.scrollView.bounces = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(self.scrollView)
        
        for i in 0..<self.controllers.count{
            let vc = self.controllers[i]
            vc.houseId = self.houseId
            vc.view.frame = CGRectMake(self.pageWidth*CGFloat(i), 0, pageWidth, pageHeight)
            self.scrollView.addSubview(vc.view)
            self.addChildViewController(vc)
        }
        self.controllers[0].updateDataIfNeeded()
    }
    
    func tapLabel(tap:UITapGestureRecognizer) -> Void{
        let x = tap.locationInView(self.view).x
        let labelWidth = UIScreen.mainScreen().bounds.width/4
        let page = Int(x/labelWidth)
        self.scrollView.setContentOffset(CGPointMake(CGFloat(page)*self.pageWidth, self.scrollView.contentOffsetY), animated: true)
    }
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let x = scrollView.contentOffsetX
        let whiteX = x/4
        self.whiteSlider.frame.origin = CGPointMake(whiteX, 64+44-3)
        if scrollView.dragging||scrollView.tracking||scrollView.decelerating{
            let currentLabel = Int(scrollView.contentOffsetX/self.pageWidth)
            self.currentPage = currentLabel
            let distance = self.labels[currentLabel].centerX - self.whiteSlider.centerX
            if fabs(distance)<=self.pageWidth/8 {
                let privious = currentLabel-1
                let next = currentLabel+1
                if privious>=0{
                    self.labels[privious].alpha = 0.5
                }
                if next<=self.labels.count-1 {
                    self.labels[next].alpha = 0.5
                }
                self.labels[currentLabel].alpha = 1.0
            }
        }
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.controllers[self.currentPage].updateDataIfNeeded()
    }

    //处理点击label,直接滚动
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if !scrollView.dragging{
            let currentLabel = Int(scrollView.contentOffsetX/self.pageWidth)
            self.currentPage = currentLabel
            self.labels[currentLabel].alpha = 1.0
            for i in 0..<self.labels.count{
                if i==currentLabel{
                    continue
                }else{
                    self.labels[i].alpha = 0.5
                }
            }
            self.controllers[self.currentPage].updateDataIfNeeded()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
