//
//  DataDetailCustomController.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/20.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class DataDetailCustomController: DataDetailBaseController, UITableViewDelegate, UITableViewDataSource, KFBCustomDateSelectorDelegate, UIViewControllerTransitioningDelegate,KFBPopCalendarControllerDelegate {
    var dataArray:[ProjectDataItem]? = nil
    let tableView = UITableView(frame: CGRectZero, style: .Grouped)
    override var itemId: Int{
        didSet{
            self.shouldUpdateData = true
        }
    }
    var dateSelector:KFBCustomDateSelector!
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateSelector = KFBCustomDateSelector(frame: CGRectZero, backgroundColor: UIColor.whiteColor(), textColor: KFBUtility.selectedColor, enbaleSeparator: true)
        self.view.addSubview(self.dateSelector)
        self.dateSelector.snp_remakeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(44)
        }
        self.dateSelector.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(DataDetailCell.self, forCellReuseIdentifier: DataDetailCell.cellIdentifier)
        self.tableView.rowHeight = DataDetailCell.cellHeight()
        self.view.addSubview(self.tableView)
        self.tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.dateSelector.snp_bottom)
            make.left.right.bottom.equalTo(self.view)
        }
        self.refreshHeader = MJRefreshNormalHeader {[unowned self] in
            self.fetchProjectDataItem()
        }
        self.refreshHeader.lastUpdatedTimeLabel.hidden = true
        self.refreshHeader.tintColor = UIColor.blackColor()
        self.tableView.mj_header = self.refreshHeader
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
    
    func updateDataAfterSelectingDate() -> Void{
        if self.startDate != nil && self.endDate != nil {
            self.shouldUpdateData = false
            self.refreshHeader.beginRefreshing()
        }else{
            self.delegate.updateHeadLabelsIfViewIsOnScreen(self.viewPage, totalCount: self.totalCount, itemCount: self.itemCount)
        }
    }
    
    override func updateDataIfNeeded() ->Void{
        if self.shouldUpdateData {
            self.updateDataAfterSelectingDate()
        }
    }
    
    override func fetchProjectDataItem() -> Void{
        let merchant = FFMemory.sharedMemory.merchant!
        let url = String(format: KFBURL.ProjectDataItem,merchant.merchantId)
        let startDateString = self.startDate!.fs_stringWithFormat("yyyy-MM-dd")
        let endDateString = self.endDate!.fs_stringWithFormat("yyyy-MM-dd")
        self.networkManager.GET(url, parameters: ["startDate":startDateString,"endDate":endDateString,"itemId":"\(self.itemId)"], progress: nil, success: {[unowned self] (task, result) in
            guard let dic = result as? [String : AnyObject]
                else{
                    self.hud.showImage(nil, status: kNetworkError)
                    return
            }
            do{
                let resp:ProjectDataItemResponse = try ProjectDataItemResponse(dictionary: dic)
                if resp.success{
                    print("fetchProjectDataItem sucess")
                    self.handleProjectDataItemResponse(resp)
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
    
    func handleProjectDataItemResponse(resp:ProjectDataItemResponse) -> Void{
        self.dataArray = resp.data as? [ProjectDataItem]
        self.itemCount = self.dataArray!.count
        var tempTotalCount:CGFloat = 0
        for item in self.dataArray!{
            tempTotalCount += item.itemData
        }
        self.totalCount = Int(tempTotalCount)
        self.tableView.reloadData()
        self.delegate.updateHeadLabelsIfViewIsOnScreen(self.viewPage, totalCount: self.totalCount, itemCount: self.itemCount)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if self.dataArray == nil {
            return 0
        }else{
            return 1
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.dataArray == nil {
            return 0
        }else{
            return self.dataArray!.count
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section==0 {
            return 5
        }
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(DataDetailCell.cellIdentifier, forIndexPath: indexPath) as! DataDetailCell
        let item = self.dataArray![indexPath.row]
        cell.leftText = item.houseName
        cell.rightText = KFBUtility.formatFloatValue(item.itemData)+"元"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.dataArray![indexPath.row]
        let houseId = Int(item.houseId)!
        print(houseId)
        self.delegate.didClickItemAtIndexPath(houseId)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.delegate.willHideWithScrollView(scrollView)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.delegate.willShowWithScrollView(scrollView)
    }
}
