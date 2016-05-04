//
//  DataDetailController.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/16.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class DataDetailController: BaseController, DataDetailTableControllerDelegate, UIScrollViewDelegate, DataDetailControllerDelegate{
    var currentPage:Int = 0
    //重选itemid在收起动画结束后刷新
    var shouldUpdateControllers:Bool = true
    var selectedIndexPath:NSIndexPath!
    let dataArray:Array<(String,[String])> = [
        ("财务",
            ["应收团购费","应收开发商款","到账团购费","到账开发商款","预约金额","认购退款(已退)金额"]),
        ("成交",
            ["认购签约套数","经纪人成交套数","C端成交套数","现场成交套数","推客成交套数"]),
        ("预约",
            ["预约套数","经纪人预约套数","C端预约套数","现场预约套数","推客预约套数"]),
        ("客户",
            ["房多多到访客户数","经纪人到访客户数","C端到访客户数","房多多报备客户数","经纪人报备客户数","C端报备客户数","推客报备客户数"])]
    /*
     0：应收团购费
     1：应收开发商款
     2：到帐团购费
     3：到账开发商款
     4：预约金额
     5：认购退款(已退)金额
     6：认购签约套数
     7：经纪人成交套数
     8：C端成交套数
     9：现场成交套数
     10：推客成交套数
     11：预约套数
     12：经纪人预约套数
     13：C端预约套数
     14：现场预约套数
     15：推客预约套数
     16：房多多到访客户数
     17：经纪人到客户访数
     18：C端到访客户数
     19：房多多报备客户数
     20：经纪人报备客户数  
     21：C端报备客户数
     22：推客报备客户数
     */
    let controllers:[DataDetailBaseController] = [DataDetailDayController(),DataDetailMonthController(),DataDetailCustomController()]
    let selectedColor = UIColor(hex: 0xFF3C6BD2)
    let unselectedColor = UIColor.grayColor()
    var titleButton:UIButton!
    let totoalCountLabel:UILabel = {
        let label = UILabel(frame: CGRectMake(0,0,KFBUtility.KFBScreenWidth,35))
        label.font = UIFont.sansProFontOfSize(35)
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = .Center
        return label
    }()
    let totalCountDetailLabel:UILabel = {
        let label = UILabel(frame: CGRectMake(0,0,KFBUtility.KFBScreenWidth,17))
        label.font = UIFont.sansProFontOfSize(17)
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = .Center
        return label
    }()
    
    let labels:[UILabel] = {
        var tempArray = [UILabel]()
        let titles = ["今天","本月","自定义"]
        let labelWidth = UIScreen.mainScreen().bounds.width/3
        for i in 0..<3{
            let label = UILabel(frame: CGRectMake(labelWidth*CGFloat(i),0,labelWidth,44))
            label.backgroundColor = UIColor.whiteColor()
            label.textColor = UIColor.grayColor()
            label.font = UIFont.systemFontOfSize(18)
            label.textAlignment = .Center
            label.text = titles[i]
            tempArray.append(label)
        }
        return tempArray
    }()
    let selectedSlider:UIView = {
        let view = UIView()
        view.frame = CGRectMake(0, 44-3.5, UIScreen.mainScreen().bounds.width/3, 3)
        view.backgroundColor = UIColor(hex: 0xFF3C6BD2)
        return view
    }()
    let pageWidth = KFBUtility.KFBScreenWidth
    let pageHeight = KFBUtility.KFBScreenHeight-64-44
    
    var pullDownTableController:DataDetailTableController!
    var pullDownTable:UITableView!
    var pullDownTableBackground:UIView!
    
    let scrollView = UIScrollView(frame: CGRectMake(0, 44,KFBUtility.KFBScreenWidth,KFBUtility.KFBScreenHeight-64-44))
    let scrollContainer = UIView(frame: CGRectMake(0,64+112,KFBUtility.KFBScreenWidth,KFBUtility.KFBScreenHeight-64))
    let headerContainer = UIView(frame: CGRectMake(0,64,KFBUtility.KFBScreenWidth,112))
    var scrollCenterUp:CGPoint!
    var scrollCenterDown:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackItem()
        //gradient layer
        let layer = CAGradientLayer.linearGradientLayerWithSize(CGSizeMake(self.view.bounds.width, 64+112))
        self.view.layer.insertSublayer(layer, atIndex: 0)
        //title button
        self.titleButton = KFBUtility.customTitleButton()
        let buttonWidth:CGFloat = 200.0
        self.titleButton.frame = CGRectMake(0, 0, buttonWidth, 44)
        let buttonTitle = dataArray[self.selectedIndexPath.section].1[self.selectedIndexPath.row]
        self.titleButton.setTitle(buttonTitle, forState: .Normal)
        self.titleButton.addTarget(self, action: #selector(self.handleTitleButton(_:)), forControlEvents: .TouchUpInside)
        self.navigationItem.titleView = UIView(frame: CGRectMake(0, 0, buttonWidth, 44))
        self.navigationItem.titleView?.addSubview(self.titleButton)
        
        //header container
        self.headerContainer.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.headerContainer)
        //header labels
        self.totoalCountLabel.center = CGPointMake(self.headerContainer.middleX, self.headerContainer.middleY-15)
        self.headerContainer.addSubview(self.totoalCountLabel)
        self.totoalCountLabel.attributedText = NSAttributedString(string: "0", attributes: [NSBaselineOffsetAttributeName:-1])
        
        self.totalCountDetailLabel.center = CGPointMake(self.view.centerX, self.totoalCountLabel.centerY+35)
        self.headerContainer.addSubview(self.totalCountDetailLabel)
        self.totalCountDetailLabel.attributedText = NSAttributedString(string: "共0个项目", attributes: [NSBaselineOffsetAttributeName:-1])
        
        //scroll container
        self.view.addSubview(self.scrollContainer)
        self.scrollCenterDown = self.scrollContainer.center
        self.scrollCenterUp = CGPointMake(self.scrollCenterDown.x, self.scrollCenterDown.y-112)
        self.scrollContainer.backgroundColor = KFBUtility.commonBackgroundColor
        //labels
        for label in self.labels{
            label.userInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapLabel(_:)))
            label.addGestureRecognizer(tap)
            self.scrollContainer.addSubview(label)
        }
        self.labels[0].textColor = self.selectedColor
        self.scrollContainer.addSubview(self.selectedSlider)
        
        let separator = KFBUtility.separatorView()
        separator.frame = CGRectMake(0, 43.5, self.pageWidth, 0.5)
        self.scrollContainer.addSubview(separator)
        
        //scrollview
        self.scrollView.contentSize = CGSizeMake(self.pageWidth*3, self.pageHeight)
        self.scrollView.delegate = self
        self.scrollView.pagingEnabled = true
        self.scrollView.bounces = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollContainer.addSubview(self.scrollView)
        
        for i in 0..<self.controllers.count{
            let vc = self.controllers[i]
            vc.view.frame = CGRectMake(self.pageWidth*CGFloat(i), 0, pageWidth, pageHeight)
            vc.delegate = self
            vc.viewPage = i
            self.addChildViewController(vc)
            self.scrollView.addSubview(vc.view)
        }
        
        //pull down table
        
        self.pullDownTableBackground = UIView(frame: CGRectMake(0,64,KFBUtility.KFBScreenWidth,KFBUtility.KFBScreenHeight-64))
        self.pullDownTableBackground.backgroundColor = UIColor.blackColor()
        self.pullDownTableBackground.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapPullDownTableBackground))
        self.pullDownTableBackground.addGestureRecognizer(tap)
        self.view.addSubview(self.pullDownTableBackground)
        
        self.pullDownTableController = DataDetailTableController(style: .Grouped)
        self.pullDownTableController.dataArray = self.dataArray
        self.pullDownTable = self.pullDownTableController.tableView
        self.pullDownTableController.DataDetailDelegate = self
        self.pullDownTable.frame = CGRectMake(0, 64,self.view.width, 0)
        self.view.addSubview(self.pullDownTable)
        
        self.pullDownTable.selectRowAtIndexPath(self.selectedIndexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
        
        self.updateControllersWithSelectedIndexPath()
    }
    
    func didClickDataDetailTableControllerItem(indexPath:NSIndexPath) -> Void{
        self.handleTitleButton(self.titleButton)
        let item = self.dataArray[indexPath.section].1[indexPath.row]
        self.titleButton.setTitle(item, forState: .Normal)
        self.selectedIndexPath = indexPath
        self.shouldUpdateControllers = true
    }
    
    func updateControllersWithSelectedIndexPath() -> Void{
        if !self.shouldUpdateControllers {
            return
        }
        self.shouldUpdateControllers = false
        let indexPath = self.selectedIndexPath
        var itemId:Int = 0
        for i in 0..<indexPath.section{
            itemId += self.dataArray[i].1.count
        }
        itemId += indexPath.row
        for controller in self.controllers {
            controller.itemId = itemId
        }
        self.controllers[self.currentPage].updateDataIfNeeded()
    }
    func didTapPullDownTableBackground() -> Void{
        self.handleTitleButton(self.titleButton)
    }
    func handleTitleButton(btn:UIButton) -> Void{
        btn.selected = !btn.selected
        if btn.selected {
            let rotate = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
            rotate.fromValue = NSNumber(float: Float(0))
            rotate.toValue = NSNumber(float: Float(-M_PI))
            btn.imageView!.layer.pop_addAnimation(rotate, forKey: "anticlock")
            
            let showAnimate = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
            showAnimate.toValue = NSNumber(float: 0.7)
            showAnimate.springBounciness = 0
            self.pullDownTableBackground.pop_addAnimation(showAnimate, forKey: "kShowAnimate")
            
            let scaleDownAnimation:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
            scaleDownAnimation.springBounciness = 0
            scaleDownAnimation.toValue = NSValue(CGRect:CGRectMake(0, 64,KFBUtility.KFBScreenWidth, KFBUtility.KFBScreenHeight-64-49-20))
            scaleDownAnimation.animationDidStartBlock = {[unowned self](anim) in
                self.pullDownTable.alpha = 1.0
                self.titleButton.userInteractionEnabled = false
            }
            scaleDownAnimation.completionBlock = {[unowned self](anim,finished) in
                if finished {
                    self.titleButton.userInteractionEnabled = true
                }
            }
            self.pullDownTable.pop_addAnimation(scaleDownAnimation, forKey: "kSaleDownAnimationMax")
            
        }else{
            let rotate = POPBasicAnimation(propertyNamed: kPOPLayerRotation)
            rotate.fromValue = NSNumber(float: Float(-M_PI))
            rotate.toValue = NSNumber(float: 0)
            btn.imageView!.layer.pop_addAnimation(rotate, forKey: "clock")
            
            let hideAnimate = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
            hideAnimate.toValue = NSNumber(float: 0)
            hideAnimate.springBounciness = 0
            
            self.pullDownTableBackground.pop_addAnimation(hideAnimate, forKey: "kHideAnimate")
            
            let scaleDownAnimation:POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
            scaleDownAnimation.springBounciness = 0
            scaleDownAnimation.toValue = NSValue(CGRect:CGRectMake(0, 64,self.view.width,0))
            scaleDownAnimation.animationDidStartBlock = {[unowned self](anim) in
                self.titleButton.userInteractionEnabled = false
            }
            scaleDownAnimation.completionBlock = {[unowned self](anim,finished) in
                if finished {
                    self.pullDownTable.alpha = 0
                    self.titleButton.userInteractionEnabled = true
                    //重设标志,动画结束后刷新
                    self.updateControllersWithSelectedIndexPath()
                }
            }
            self.pullDownTable.pop_addAnimation(scaleDownAnimation, forKey: "kSaleDownAnimationMin")
        }
    }
    
    func tapLabel(tap:UITapGestureRecognizer) -> Void{
        let x = tap.locationInView(self.view).x
        let labelWidth = KFBUtility.KFBScreenWidth/3
        let page = Int(x/labelWidth)
        self.scrollView.setContentOffset(CGPointMake(CGFloat(page)*self.pageWidth, self.scrollView.contentOffsetY), animated: true)
    }
    
    func didClickItemAtIndexPath(houseId:Int) -> Void{
        self.hidesBottomBarWhenPushed = true
        let controller = OperationDataController()
        controller.houseId = houseId
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func willHideWithScrollView(scrollView:UIScrollView) {
        if scrollView.contentOffsetY > 0 {
            if self.scrollContainer.centerY>self.scrollCenterUp.y {
                UIView.animateWithDuration(0.4, animations: {
                    self.scrollContainer.center = self.scrollCenterUp
                })
            }
        }
    }
    func willShowWithScrollView(scrollView:UIScrollView) {
        if scrollView.contentOffsetY <= 0 {
            if self.scrollContainer.centerY < self.scrollCenterDown.y {
                UIView.animateWithDuration(0.4, animations: {
                    self.scrollContainer.center = self.scrollCenterDown
                })
            }
        }
    }
    func updateHeadLabelsIfViewIsOnScreen(page:Int, totalCount:Int, itemCount:Int) {
        if self.currentPage == page {
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .DecimalStyle
            let str = formatter.stringFromNumber(NSNumber(integer: totalCount))
            self.totoalCountLabel.text = str
            self.totalCountDetailLabel.text = "共\(itemCount)个项目"
        }
    }
    
    func updateCurrentHeadLabels() -> Void{
        let controller = self.controllers[currentPage]
        if controller.shouldUpdateData{
            controller.updateDataIfNeeded()
        }else{
            self.updateHeadLabelsIfViewIsOnScreen(self.currentPage, totalCount: controller.totalCount, itemCount: controller.itemCount)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let x = scrollView.contentOffsetX
        let selectedX = x/3
        self.selectedSlider.frame.origin = CGPointMake(selectedX, 44-3.5)
        if scrollView.dragging||scrollView.tracking||scrollView.decelerating{
            let currentLabel = Int(scrollView.contentOffsetX/self.pageWidth)
            self.currentPage = currentLabel
            let distance = self.labels[currentLabel].centerX - self.selectedSlider.centerX
            if fabs(distance)<=self.pageWidth/6 {
                let privious = currentLabel-1
                let next = currentLabel+1
                if privious>=0{
                    self.labels[privious].textColor = self.unselectedColor
                }
                if next<=self.labels.count-1 {
                    self.labels[next].textColor = self.unselectedColor
                }
                self.labels[currentLabel].textColor = self.selectedColor
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.updateCurrentHeadLabels()
    }
    //处理点击label,直接滚动
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if !scrollView.dragging{
            let currentLabel = Int(scrollView.contentOffsetX/self.pageWidth)
            self.currentPage = currentLabel
            self.labels[currentLabel].textColor = self.selectedColor
            for i in 0..<self.labels.count{
                if i==currentLabel{
                    continue
                }else{
                    self.labels[i].textColor = self.unselectedColor
                }
            }
            self.updateCurrentHeadLabels()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
