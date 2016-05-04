//
//  GatherController.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/12.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class GatherController: BaseController, UITableViewDelegate, UITableViewDataSource, KFBHeaderCalendarViewDelegate, UIViewControllerTransitioningDelegate, KFBPopCalendarControllerDelegate{
    var headerCalendar:KFBHeaderCalendarView!
    var dataArray:Array<(String,[(String,String)])> = [
        ("",[]),
        ("财务",
            [("应收团购费","0元"),("应收开发商款","0元"),("到账团购费","0元"),("到账开发商款","0元"),("预约金额","0元"),("认购退款(已退)金额","0元")]),
        ("成交",
            [("认购签约套数","0套"),("经纪人成交套数","0套"),("C端成交套数","0套"),("现场成交套数","0套"),("推客成交套数","0套")]),
        ("预约",
            [("预约套数","0套"),("经纪人预约套数","0套"),("C端预约套数","0套"),("现场预约套数","0套"),("推客预约套数","0套")]),
        ("客户",
            [("房多多到访客户数","0人"),("经纪人到访客户数","0人"),("C端到访客户数","0人"),("房多多报备客户数","0人"),("经纪人报备客户数","0人"),("C端报备客户数","0人"),("推客报备客户数","0人")])]
    var tableRefreshHeader:MJRefreshNormalHeader!
    var tableView:UITableView!
    let gradientHeight = CGFloat(64+112+4)
    let gradientWidth = UIScreen.mainScreen().bounds.width
    let gradientLayer:CALayer = CALayer.radialGradientLayerWithSize(CGSizeMake(UIScreen.mainScreen().bounds.width, (64+112+4)))
    let backgroundLayer:CALayer = {
        let layer = CALayer()
        layer.frame = CGRectMake(0, 64+112+4, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-64-112-4-49)
        layer.backgroundColor = KFBUtility.commonBackgroundColor.CGColor
        return layer
    }()
    var currentDate:NSDate = NSDate(){
        didSet{
            if !self.tableRefreshHeader.hidden {
                if FFMemory.sharedMemory.merchant != nil{
                self.tableRefreshHeader.beginRefreshing()
                }
            }
        }
    }
    var shouldRefreshAfterLogin:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.resetMerchant), name: kNotificationResetMerchant, object: nil)
        self.edgesForExtendedLayout = .Top
        if let merchant = FFMemory.sharedMemory.merchant {
            self.navigationItem.title = merchant.merchantName
        }
        //add header gradient
        self.view.layer.insertSublayer(self.gradientLayer, atIndex: 0)
        self.view.layer.insertSublayer(self.backgroundLayer, atIndex: 0)
        //add header Calendar
        self.configureTableView()
        if (FFMemory.sharedMemory.merchant) != nil {
            self.tableRefreshHeader.hidden = false
            if !self.shouldRefreshAfterLogin {
                self.tableRefreshHeader.beginRefreshing()
            }
        }else{
            self.tableRefreshHeader.hidden = true
        }
    }
    override func viewDidAppear(animated:Bool){
        super.viewDidAppear(animated)
        if self.shouldRefreshAfterLogin {
            self.shouldRefreshAfterLogin = false
            let merchant = FFMemory.sharedMemory.merchant
            self.navigationItem.title = merchant!.merchantName
            self.tableRefreshHeader.hidden = false
            self.tableRefreshHeader.beginRefreshing()
        }
    }
    
    override func resetHTTPHeader() {
        super.resetHTTPHeader()
        print("gather reset")
        self.shouldRefreshAfterLogin = true
    }
    
    func resetMerchant() -> Void{
        self.shouldRefreshAfterLogin = true
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(ProjectHeaderCell.cellIdentifier, forIndexPath: indexPath) as! ProjectHeaderCell
            self.headerCalendar = cell.headerCalendar
            cell.headerCalendar.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(GatherCommonCell.cellIdentifier, forIndexPath: indexPath) as! GatherCommonCell
            let data = self.dataArray[indexPath.section].1[indexPath.row]
            cell.leftText = data.0
            cell.rightText = data.1
            if (indexPath.row == 0 && indexPath.section != 1) || indexPath.row == self.dataArray[indexPath.section].1.count-1{
                cell.showFullSeparator(true)
            }else{
                cell.showFullSeparator(false)
            }
            if indexPath.row == 0 {
                cell.showHeaderSeparator(true)
            }else{
                cell.showHeaderSeparator(false)
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section==0 && indexPath.row==0 {
            return ProjectHeaderCell.cellHeight()
        }else{
            return GatherCommonCell.cellHeight()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return 1
        }
        return self.dataArray[section].1.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0 {
            return 0.0001
        }
        return KFBTableViewHeaderFooterView.cellHeight()
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section==0 {
            return nil
        }
        return self.dataArray[section].0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section==0 {
            return nil
        }
        let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier(KFBTableViewHeaderFooterView.cellIdentifier)
        view?.contentView.backgroundColor = KFBUtility.commonBackgroundColor
        return view
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section>0 {
            if FFMemory.sharedMemory.merchant == nil {
                self.hud.showImage(nil, status:"请重新登录")
                return
            }
            let controller:DataDetailController = DataDetailController()
            controller.selectedIndexPath = NSIndexPath(forRow: indexPath.row, inSection: indexPath.section-1)
            self.hidesBottomBarWhenPushed = true
//            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
            self.navigationController?.pushViewController(controller, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
    }
    
    func configureTableView() -> Void{
        self.tableView = UITableView(frame: CGRectMake(0, 64, self.view.width, self.view.height-49-64), style: .Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorStyle = .None
        self.tableView.directionalLockEnabled = true
        self.tableRefreshHeader = MJRefreshNormalHeader {[unowned self] in
            self.fetchMerchantHomePage()
        }
        tableRefreshHeader.arrowView.image = UIImage(named: "arrowWhite")
        tableRefreshHeader.activityIndicatorViewStyle = .White
        tableRefreshHeader.lastUpdatedTimeLabel.hidden = true
        tableRefreshHeader.stateLabel.textColor = UIColor.whiteColor()
        self.tableView.mj_header = tableRefreshHeader
        
        self.tableView.registerClass(KFBTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: KFBTableViewHeaderFooterView.cellIdentifier)
        self.tableView.registerClass(ProjectHeaderCell.self, forCellReuseIdentifier: ProjectHeaderCell.cellIdentifier)
        self.tableView.registerClass(GatherCommonCell.self, forCellReuseIdentifier: GatherCommonCell.cellIdentifier)
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
    
    func didClickHeaderCalendarViewItem(item:String){
        let modalVC = KFBPopCalendarController()
        modalVC.currentDate = self.currentDate
        modalVC.calendarDelegate = self
        modalVC.transitioningDelegate = self
        modalVC.modalPresentationStyle = .Custom
        self.presentViewController(modalVC, animated: true, completion: nil)
    }
    func didConfirmDateSelection(date: NSDate) {
        self.headerCalendar.scrollToDate(date,animated: true)
    }
    func didScrollToDate(date:NSDate) {
        self.currentDate = date
    }
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return KFBPopCalendarPresentingController()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return KFBPopCalendarDismissingController()
    }
    
    
    func fetchMerchantHomePage() -> Void{
        let merchant = FFMemory.sharedMemory.merchant
        let url:String = String(format: KFBURL.MerchantHomePage, Int((merchant!.merchantId)))
        let dateString = self.currentDate.fs_stringWithFormat("yyyy-MM-dd")
        self.networkManager.GET(url, parameters: ["date":dateString], progress: nil, success: {[unowned self] (task, result) in
            guard let dic = result as? [String : AnyObject]
                else{
                    self.hud.showImage(nil, status: kNetworkError)
                    return
            }
            do{
                let resp:MerchantHomePageResponse = try MerchantHomePageResponse(dictionary: dic)
                if resp.success{
                    print("fetchProjectHomePageData sucess")
                    self.handleMerchantHomePage(resp.data)
                }else{
                    self.hud.showImage(nil, status: resp.msg)
                }
            }catch _{
                self.hud.showImage(nil, status: kNetworkError)
            }
            self.tableRefreshHeader.endRefreshing()
            }) {[unowned self] (task, error) in
                print(error.localizedDescription)
                self.tableRefreshHeader.endRefreshing()
                self.hud.showImage(nil, status: kNetworkError)
        }
    }
    
    func handleMerchantHomePage(data:MerchantHomePage) -> Void{
        let receiveShouldGroupAtm:String = KFBUtility.formatFloatValue(data.receiveShouldGroupAtm)
        let receiveShouldDeveloperAtm:String = KFBUtility.formatFloatValue(data.receiveShouldDeveloperAtm)
        let receiveAlreadyGroupAtm:String = KFBUtility.formatFloatValue(data.receiveAlreadyGroupAtm)
        let receiveAlreadyDeveloperAtm:String = KFBUtility.formatFloatValue(data.receiveAlreadyDeveloperAtm)
        let orderMoney:String = KFBUtility.formatFloatValue(data.orderMoney)
        let refundMoney:String = KFBUtility.formatFloatValue(data.refundMoney)
        self.dataArray = [
        ("",[]),
        ("财务",
        [("应收团购费",receiveShouldGroupAtm+"元"),("应收开发商款",receiveShouldDeveloperAtm+"元"),("到账团购费",receiveAlreadyGroupAtm+"元"),("到账开发商款",receiveAlreadyDeveloperAtm+"元"),("预约金额",orderMoney+"元"),("认购退款(已退)金额",refundMoney+"元")]),
        ("成交",
        [("认购签约套数","\(data.signNumber)套"),("经纪人成交套数","\(data.agentDealNumber)套"),("C端成交套数","\(data.onlineDealNumber)套"),("现场成交套数","\(data.sceneDealNumber)套"),("推客成交套数","\(data.pushDealNumber)套")]),
        ("预约",
        [("预约套数","\(data.orderNumber)套"),("经纪人预约套数","\(data.agentOrderNumber)套"),("C端预约套数","\(data.onlineOrderNumber)套"),("现场预约套数","\(data.onlineOrderNumber)套"),("推客预约套数","\(data.pushOrderNumber)套")]),
        ("客户",
        [("房多多到访客户数","\(data.visitCustomerNumber)人"),("经纪人到访客户数","\(data.agentVisitCustomer)人"),("C端到访客户数","\(data.onlineVisitCustomer)人"),("房多多报备客户数","\(data.recordCustomerNumber)人"),("经纪人报备客户数","\(data.agentRecordCustomer)人"),("C端报备客户数","\(data.onlineRecordCustomer)人"),("推客报备客户数","\(data.pushRecordCustomer)人")])]
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


