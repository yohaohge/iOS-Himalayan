//
//  CustomReportController.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/16.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class CustomReportController: OperationDataReportBaseController ,UITableViewDelegate, UITableViewDataSource, KFBCustomDateSelectorDelegate, UIViewControllerTransitioningDelegate,KFBPopCalendarControllerDelegate {
    var tableView:UITableView!
    var dateSelector:KFBCustomDateSelector!
    weak var dateSelectorHeight:ConstraintDescriptionExtendable!
    var startDate:NSDate? = nil{
        didSet{
            self.dateSelector.startDate = startDate!
            self.updateDataAfterSelectingDate()
        }
    }
    var endDate:NSDate? = nil{
        didSet{
            self.dateSelector.endDate = endDate!
            self.updateDataAfterSelectingDate()
        }
    }
    var dateForStart:Bool = true
    var dataArray:Array<(String,[(String,String)])> = [
        ("认购签约",
            [("认购及签约套数","0套"),("应收团购费","0元"),("到账团购费","0元"),("应收开发商款","0元"),("到账开发商款","0元")]),
        ("预约情况",
            [("预约单数","0单"),("预约金额","0元")]),
        ("退房退款",
            [("认购退房套数","0套"),("认购退款金额","0元")]),
        ("成交客户",
            [("总成交套数","0套"),("经纪人成交套数","0套"),("C端成交套数","0套"),("推客成交套数","0套"),("现场成交套数 ","0套")]),
        ("到访客户",
            [("房多多到访客户数","0人"),("经纪人到访数","0人"),("C端到访数","0人"),("推客到访数","0人")]),
        ("报备客户",
            [("房多多报备客户数","0人"),("经纪人报备数","0人"),("C端报备数","0人"),("推客报备数","0人")])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        
        self.configureDateSelector()
        self.configureTableView()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray[section].1.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(OperationLeftRightTextCell.cellIdentifier) as!
        OperationLeftRightTextCell
        let t = (self.dataArray[indexPath.section].1)[indexPath.row]
        cell.leftText = t.0
        cell.rightText = t.1
        if indexPath.row == 0 || indexPath.row == self.dataArray[indexPath.section].1.count-1{
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return OperationLeftRightTextCell.OperationCellHeight()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataArray[section].0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier(KFBTableViewHeaderFooterView.cellIdentifier)
        view?.contentView.backgroundColor = KFBUtility.commonBackgroundColor
        return view
    }
    
    func configureDateSelector() -> Void{
        self.dateSelector = KFBCustomDateSelector(frame: CGRectZero, backgroundColor: UIColor(hex: 0x071b36, alpha: 0.2), textColor: UIColor.whiteColor(), enbaleSeparator: false)
        self.view.addSubview(self.dateSelector)
        self.dateSelector.snp_remakeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(44)
        }
        self.dateSelector.delegate = self
    }
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return KFBPopCalendarPresentingController()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return KFBPopCalendarDismissingController()
    }
    func didConfirmDateSelection(date:NSDate) {
        if dateForStart {
            self.startDate = date
        }else{
            self.endDate = date
        }
    }
    func didClickStartDate(date:NSDate) -> Void{
        self.dateForStart = true
        let modalVC = KFBPopCalendarController()
        if  let tempDate = self.endDate {
            modalVC.maximumDate = tempDate
        }
        modalVC.currentDate = date
        modalVC.calendarDelegate = self
        modalVC.transitioningDelegate = self
        modalVC.modalPresentationStyle = .Custom
        self.presentViewController(modalVC, animated: true, completion: nil)
    }
    func didClickEndDate(date:NSDate) -> Void{
        self.dateForStart = false
        let modalVC = KFBPopCalendarController()
        if let tempDate = self.startDate{
            modalVC.minimumDate = tempDate
        }
        modalVC.currentDate = date
        modalVC.calendarDelegate = self
        modalVC.transitioningDelegate = self
        modalVC.modalPresentationStyle = .Custom
        self.presentViewController(modalVC, animated: true, completion: nil)
    }
    
    func configureTableView() -> Void{
        self.tableView = UITableView(frame: CGRectZero, style: .Grouped)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.tableView.backgroundColor = UIColor.clearColor()
        
        self.refreshHeader = MJRefreshNormalHeader {[unowned self] in
            self.fetchProjectReportData()
        }
        self.refreshHeader.backgroundColor = KFBUtility.commonBackgroundColor
        self.refreshHeader.lastUpdatedTimeLabel.hidden = true
        self.refreshHeader.tintColor = UIColor.blackColor()
        self.tableView.mj_header = self.refreshHeader
        
        self.tableView.registerClass(OperationLeftRightTextCell.self, forCellReuseIdentifier: OperationLeftRightTextCell.cellIdentifier)
        self.tableView.registerClass(KFBTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: KFBTableViewHeaderFooterView.cellIdentifier)
        self.view.addSubview(self.tableView)
        self.tableView.snp_remakeConstraints { (make) in
            make.top.equalTo(self.dateSelector.snp_bottom)
            make.left.right.bottom.equalTo(self.view)
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffsetY > 0{
            if self.dateSelector.height > 0 {
                self.dateSelector.snp_updateConstraints(closure: { (make) in
                    make.height.equalTo(0)
                })
                UIView.animateWithDuration(0.25, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }else{
            if self.dateSelector.height == 0 {
                self.dateSelector.snp_updateConstraints(closure: { (make) in
                    make.height.equalTo(44)
                })
                UIView.animateWithDuration(0.25, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func updateDataAfterSelectingDate() {
        if self.startDate != nil && self.endDate != nil {
            self.refreshHeader.beginRefreshing()
        }
    }
    override func fetchProjectReportData() -> Void{
        let url = String(format: KFBURL.ProjectReportData,self.houseId)
        let startDateString = self.startDate!.fs_stringWithFormat("yyyy-MM-dd")
        let endDateString = self.endDate!.fs_stringWithFormat("yyyy-MM-dd")
        self.networkManager.GET(url, parameters: ["startDate":startDateString,"endDate":endDateString], progress: nil, success: {[unowned self] (task, result) in
            guard let dic = result as? [String : AnyObject]
                else{
                    self.hud.showImage(nil, status: kNetworkError)
                    return
            }
            do{
                let resp:ProjectReportDataResponse = try ProjectReportDataResponse(dictionary: dic)
                if resp.success{
                    print("fetchProjectHomePageData sucess")
                    self.handleProjectReportData(resp.data)
                }else{
                    self.hud.showImage(nil, status: resp.msg)
                }
            }catch _{
                self.hud.showImage(nil, status: kNetworkError)
            }
            self.refreshHeader.endRefreshing()
            }, failure: {[unowned self] (task, error) in
                print(error.localizedDescription)
                self.refreshHeader.endRefreshing()
                self.hud.showImage(nil, status: kNetworkError)
            })
    }
    func handleProjectReportData(data:ProjectReportData) ->Void{
        let receiveShouldGroupAtm:String = KFBUtility.formatFloatValue(data.receiveShouldGroupAtm)
        let receiveAlreadyGroupAtm:String = KFBUtility.formatFloatValue(data.receiveAlreadyGroupAtm)
        let receiveShouldDeveloperAtm:String = KFBUtility.formatFloatValue(data.receiveShouldDeveloperAtm)
        let receiveAlreadyDeveloperAtm:String = KFBUtility.formatFloatValue(data.receiveAlreadyDeveloperAtm)
        let orderMoney = KFBUtility.formatFloatValue(data.orderMoney)
        let refundMoney = KFBUtility.formatFloatValue(data.refundMoney)
        self.dataArray = [
            ("认购签约",
                [("认购及签约套数","\(data.signNumber)套"),("应收团购费","\(receiveShouldGroupAtm)元"),("到账团购费","\(receiveAlreadyGroupAtm)元"),("应收开发商款","\(receiveShouldDeveloperAtm)元"),("到账开发商款","\(receiveAlreadyDeveloperAtm)元")]),
            ("预约情况",
                [("预约单数","\(data.orderFormNumber)单"),("预约金额","\(orderMoney)元")]),
            ("退房退款",
                [("认购退房套数","\(data.refundNumber)套"),("认购退款金额","\(refundMoney)元")]),
            ("成交客户",
                [("总成交套数","\(data.dealNumber)套"),("经纪人成交套数","\(data.agentDealNumber)套"),("C端成交套数","\(data.onlineDealNumber)套"),("推客成交套数","\(data.pushDealNumber)套"),("现场成交套数 ","\(data.sceneDealNumber)套")]),
            ("到访客户",
                [("房多多到访客户数","\(data.visitCustomerNumber)人"),("经纪人到访数","\(data.agentVisitCustomer)人"),("C端到访数","\(data.onlineVisitCustomer)人")]),
            ("报备客户",
                [("房多多报备客户数","\(data.recordCustomerNumber)人"),("经纪人报备数","\(data.agentRecordCustomer)人"),("C端报备数","\(data.onlineRecordCustomer)人"),("推客报备数","\(data.pushRecordCustomer)人")])]
        self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}