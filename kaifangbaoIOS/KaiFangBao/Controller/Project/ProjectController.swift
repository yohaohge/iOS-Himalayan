//
//  ProjectController.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/16.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class ProjectController: BaseController, UITableViewDelegate, UITableViewDataSource, KFBHeaderCalendarViewDelegate, UIViewControllerTransitioningDelegate, ProjectTableControllerDelegate, KFBPopCalendarControllerDelegate{
    var headerCalendar:KFBHeaderCalendarView!
    var dataOne:Array<(String,String)> = [("",""),("认购及签约套数","0"),("应收团购费","0"),("到账团购费","0"),("预约套数","0"),("预约金额","0")]
    
    var dataTwo:Array<(String,String)> = [("",""),("房多多到访客户数","0"),("经纪客户 0,C端 0",""),("房多多报备客户数","0"),("经纪客户 0,C端 0,推客 0","")]
    var houseList:[House]?
    var tableRefreshHeader:MJRefreshNormalHeader!
    var tableView:UITableView!
    let gradientHeight = CGFloat(64+112+44+4)
    let gradientWidth = UIScreen.mainScreen().bounds.width
    let gradientLayer:CALayer = CALayer.radialGradientLayerWithSize(CGSizeMake(UIScreen.mainScreen().bounds.width, (64+112+44+4)))
    var titleButton:UIButton!
    var pullDownTableController:ProjectTableController!
    var pullDownTable:UITableView!
    var pullDownTableBackground:UIView!
    var currentDate:NSDate = NSDate(){
        didSet{
            if !self.tableRefreshHeader.hidden {
                if FFMemory.sharedMemory.house != nil{
                    self.tableRefreshHeader.beginRefreshing()
                }
            }
        }
    }
    var shouldRefreshAfterLogin:Bool = false
    var pullDownTableHeight:CGFloat = KFBUtility.KFBScreenHeight-64-49-49-20
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .Top
        
        self.titleButton = KFBUtility.customTitleButton()
        let buttonWidth:CGFloat = 200.0
        self.titleButton.frame = CGRectMake(0, 0, buttonWidth, 44)
        
        if let house = FFMemory.sharedMemory.house{
            self.titleButton.setTitle(house.houseName, forState: .Normal)
        }else{
            self.titleButton.setTitle("选择楼盘", forState: .Normal)
        }
        
        self.titleButton.addTarget(self, action: #selector(self.handleTitleButton(_:)), forControlEvents: .TouchUpInside)
        self.navigationItem.titleView = UIView(frame: CGRectMake(0, 0, buttonWidth, 44))
        self.navigationItem.titleView?.addSubview(self.titleButton)
        //add header gradient
        self.view.layer.insertSublayer(self.gradientLayer, atIndex: 0)
        //add header Calendar
        self.configureTableView()
        
        //pull down table
        self.pullDownTableBackground = UIView(frame: CGRectMake(0,64,KFBUtility.KFBScreenWidth,KFBUtility.KFBScreenHeight-64-49))
        self.pullDownTableBackground.backgroundColor = UIColor.blackColor()
        self.pullDownTableBackground.alpha = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapPullDownTableBackground))
        self.pullDownTableBackground.addGestureRecognizer(tap)
        self.view.addSubview(self.pullDownTableBackground)
        
        self.pullDownTableController = ProjectTableController(style: .Grouped)
        self.pullDownTable = self.pullDownTableController.tableView
        self.pullDownTableController.DataDetailDelegate = self
        self.pullDownTable.frame = CGRectMake(0, 64,self.view.width, 0)
        self.view.addSubview(self.pullDownTable)
        self.pullDownTable.alpha = 0
        
        if (FFMemory.sharedMemory.house) != nil {
            self.tableRefreshHeader.hidden = false
            self.titleButton.setTitle(FFMemory.sharedMemory.house!.houseName, forState: .Normal)
            self.tableRefreshHeader.beginRefreshing()
        }else{
            self.tableRefreshHeader.hidden = true
            self.titleButton.setTitle("选择楼盘", forState: .Normal)
        }
        self.fetchHouseList()
    }
    override func viewWillAppear(animated:Bool){
        super.viewWillAppear(animated)
        if self.shouldRefreshAfterLogin {
            self.shouldRefreshAfterLogin = false
            self.tableRefreshHeader.hidden = true
            self.titleButton.setTitle("选择楼盘", forState: .Normal)
            self.fetchHouseList()
        }
    }
    //after resetHTTPHeader house is not selected
    override func resetHTTPHeader() {
        super.resetHTTPHeader()
        self.shouldRefreshAfterLogin = true
    }
    func didClickProjectTableItem(house:House) {
        self.handleTitleButton(self.titleButton)
        self.titleButton.setTitle(house.houseName, forState: .Normal)
        FFMemory.sharedMemory.house = house
        self.tableRefreshHeader.hidden = false
        self.tableRefreshHeader.beginRefreshing()
    }
    func reloadHouseList(){
        self.fetchHouseList()
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
            scaleDownAnimation.toValue = NSValue(CGRect:CGRectMake(0, 64,KFBUtility.KFBScreenWidth, self.pullDownTableHeight))
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
                }
            }
            self.pullDownTable.pop_addAnimation(scaleDownAnimation, forKey: "kSaleDownAnimationMin")
            
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier(ProjectHeaderCell.cellIdentifier) as! ProjectHeaderCell
                cell.headerCalendar.delegate = self
                self.headerCalendar = cell.headerCalendar
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier(ProjectReportCell.cellIdentifier, forIndexPath: indexPath) as! ProjectReportCell
                cell.textLabel?.text = "运营简报"
                return cell
            }
        case 1:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier(ProjectSectionHeaderCell.cellIdentifier, forIndexPath: indexPath) as! ProjectSectionHeaderCell
                cell.title = "订单"
                return cell
            case 6:
                let cell = tableView.dequeueReusableCellWithIdentifier(ProjectSectionFooterCell.cellIdentifier, forIndexPath: indexPath) as! ProjectSectionFooterCell
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier(ProjectLeftRightTextCell.cellIdentifier, forIndexPath: indexPath) as! ProjectLeftRightTextCell
                let t = dataOne[indexPath.row]
                cell.leftText = t.0
                cell.rightText = t.1
                return cell
            }
        case 2:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier(ProjectSectionHeaderCell.cellIdentifier, forIndexPath: indexPath) as! ProjectSectionHeaderCell
                cell.title = "客户"
                return cell
            case 1,3:
                let cell = tableView.dequeueReusableCellWithIdentifier(ProjectLeftRightTextCell.cellIdentifier, forIndexPath: indexPath) as! ProjectLeftRightTextCell
                let t = dataTwo[indexPath.row]
                cell.leftText = t.0
                cell.rightText = t.1
                return cell
            case 2,4:
                let cell = tableView.dequeueReusableCellWithIdentifier(ProjectContentSeparatedCell.cellIdentifier, forIndexPath: indexPath) as! ProjectContentSeparatedCell
                let t = dataTwo[indexPath.row]
                cell.labelContent = t.0
                if indexPath.row == 2{
                    cell.showFullSeparator(false)
                }else{
                    cell.showFullSeparator(true)
                }
                return cell
            default:
                return BaseProjectCell()
            }
        default:
            return BaseProjectCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return ProjectHeaderCell.cellHeight()
            default:
                return ProjectReportCell.cellHeight()
            }
        case 1:
            switch indexPath.row {
            case 6:
                return ProjectSectionFooterCell.cellHeight()
            default:
                return ProjectSectionHeaderCell.cellHeight()
            }
        case 2:
            return ProjectSectionHeaderCell.cellHeight()
        default:
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 7
        case 2:
            return 5
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if FFMemory.sharedMemory.house == nil {
            self.hud.showImage(nil, status:"请选择楼盘")
            return
        }
        if indexPath.row==1&&indexPath.section==0{
            let controller = OperationDataController()
            controller.houseId = Int(FFMemory.sharedMemory.house!.houseId)!
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
    }
    
    func configureTableView() -> Void{
        self.tableView = UITableView(frame: CGRectMake(0, 64, self.view.width, self.view.height-49-64), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorStyle = .None
        self.tableView.directionalLockEnabled = true
        // configure tableRefreshHeader
        self.tableRefreshHeader = MJRefreshNormalHeader {[unowned self] in
            self.fetchProjectHomePageData()
        }
        self.tableRefreshHeader.arrowView.image = UIImage(named: "arrowWhite")
        self.tableRefreshHeader.activityIndicatorViewStyle = .White
        self.tableRefreshHeader.lastUpdatedTimeLabel.hidden = true
        self.tableRefreshHeader.stateLabel.textColor = UIColor.whiteColor()
        self.tableView.mj_header = self.tableRefreshHeader
        
        self.tableView.registerClass(ProjectHeaderCell.self, forCellReuseIdentifier: ProjectHeaderCell.cellIdentifier)
        self.tableView.registerClass(ProjectReportCell.self, forCellReuseIdentifier: ProjectReportCell.cellIdentifier)
        self.tableView.registerClass(ProjectSectionHeaderCell.self, forCellReuseIdentifier: ProjectSectionHeaderCell.cellIdentifier)
        self.tableView.registerClass(ProjectSectionFooterCell.self, forCellReuseIdentifier: ProjectSectionFooterCell.cellIdentifier)
        self.tableView.registerClass(ProjectLeftRightTextCell.self, forCellReuseIdentifier: ProjectLeftRightTextCell.cellIdentifier)
        self.tableView.registerClass(ProjectContentSeparatedCell.self, forCellReuseIdentifier: ProjectContentSeparatedCell.cellIdentifier)
        
        self.view.addSubview(self.tableView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let y:CGFloat = -scrollView.contentOffset.y
        //限制下拉,高度与头部cell高度相同
        if y>112{
            scrollView.contentOffset = CGPointMake(0, -112)
            return
        }
        //等比缩放背景渐变层,渐变层缩放加速度要大于下拉加速度
        if y >= 0 {
            var height:CGFloat = self.gradientHeight+y*8
            if height > self.tableView.height {
                height = self.tableView.height
            }
            if !self.tableRefreshHeader.hidden {
                height += 50
            }
            let scale = height/self.gradientHeight
            self.gradientLayer.setAffineTransform(CGAffineTransformMakeScale(scale,scale))
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if FFMemory.sharedMemory.house == nil {
            self.hud.showImage(nil, status:"请选择楼盘")
            return
        }
    }
    
    func didClickHeaderCalendarViewItem(item:String){
        let modalVC = KFBPopCalendarController()
        modalVC.currentDate = self.currentDate
        modalVC.calendarDelegate = self
        modalVC.transitioningDelegate = self
        modalVC.modalPresentationStyle = .Custom
        self.presentViewController(modalVC, animated: true, completion: nil)
    }
    func didScrollToDate(date:NSDate) {
        self.currentDate = date
    }
    func didConfirmDateSelection(date:NSDate){
        self.headerCalendar.scrollToDate(date, animated: true)
    }
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return KFBPopCalendarPresentingController()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return KFBPopCalendarDismissingController()
    }
    func fetchHouseList() -> Void{
        if let merchant = FFMemory.sharedMemory.merchant{
            let url = String(format: KFBURL.HouseList, Int(merchant.merchantId))
            self.networkManager.GET(url, parameters: nil, progress: nil, success: {[unowned self] (task, result) in
                guard let dic = result as? [String : AnyObject]
                    else{
                        self.hud.showImage(nil, status: kNetworkError)
                        return
                }
                do{
                    let resp:HouseListResponse = try HouseListResponse(dictionary: dic)
                    if resp.success{
                        print("fetchHouseList sucess")
                        self.houseList = resp.data as? [House]
                        self.pullDownTableHeight = 16.0+ProjectCheckMarkCell.cellHeight()*CGFloat(self.houseList!.count)
                        self.pullDownTableController.dataArray = self.houseList
                    }else{
                        print("fetchHouseList failed")
                        self.hud.showImage(nil, status: resp.msg)
                        self.pullDownTableController.dataArray = nil
                    }
                }catch _{
                    self.pullDownTableController.dataArray = nil
                    self.hud.showImage(nil, status: kNetworkError)
                }
                
                }, failure: {[unowned self] (task, error) in
                    print(error.localizedDescription)
                    self.pullDownTableController.dataArray = nil
                    self.hud.showImage(nil, status: kNetworkError)
                })
        }
    }
    func fetchProjectHomePageData() -> Void{
        let house = FFMemory.sharedMemory.house
        let url = String(format: KFBURL.ProjectHomePage, Int(house!.houseId)!)
        let dateString = self.currentDate.fs_stringWithFormat("yyyy-MM-dd")
        self.networkManager.GET(url, parameters: ["date":dateString], progress: nil, success: {[unowned self] (task, result) in
            guard let dic = result as? [String : AnyObject]
                else{
                    self.hud.showImage(nil, status: kNetworkError)
                    return
            }
            do{
                let resp:ProjectHomePageResponse = try ProjectHomePageResponse(dictionary: dic)
                if resp.success{
                    print("fetchProjectHomePageData sucess")
                    self.handleProjectHomePageData(resp.data)
                }else{
                    self.hud.showImage(nil, status: resp.msg)
                }
            }catch _{
                self.hud.showImage(nil, status: kNetworkError)
            }
            self.tableRefreshHeader.endRefreshing()
            }, failure: {[unowned self] (task, error) in
                print(error.localizedDescription)
                self.tableRefreshHeader.endRefreshing()
                self.hud.showImage(nil, status: kNetworkError)
            })
    }
    func handleProjectHomePageData(data:ProjectHomePage) -> Void{
        //处理小数点
        let receiveShouldGroupAtm:String = KFBUtility.formatFloatValue(data.receiveShouldGroupAtm)
        let receiveAlreadyGroupAtm:String = KFBUtility.formatFloatValue(data.receiveAlreadyGroupAtm)
        let orderMoney:String = KFBUtility.formatFloatValue(data.orderMoney)
        
        self.dataOne = [("",""),
                        ("认购及签约套数","\(data.signNumber)"),
                        ("应收团购费",receiveShouldGroupAtm),
                        ("到账团购费",receiveAlreadyGroupAtm),
                        ("预约套数","\(data.orderNumber)"),
                        ("预约金额",orderMoney)]
        
        self.dataTwo = [("",""),
                        ("房多多到访客户数","\(data.visitCustomerNumber)"),
                        ("经纪客户 \(data.agentVisitCustomer),C端 \(data.onlineVisitCustomer)",""),
                        ("房多多报备客户数","\(data.recordCustomerNumber)"),
                        ("经纪客户 \(data.agentRecordCustomer),C端 \(data.onlineRecordCustomer),推客 \(data.pushRecordCustomer)","")]
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
