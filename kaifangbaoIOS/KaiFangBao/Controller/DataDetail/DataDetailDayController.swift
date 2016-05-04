//
//  DataDetailDayController.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/20.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

protocol DataDetailControllerDelegate:NSObjectProtocol {
    func didClickItemAtIndexPath(houseId:Int) -> Void
    func willHideWithScrollView(scrollView:UIScrollView) -> Void
    func willShowWithScrollView(scrollView:UIScrollView) -> Void
    func updateHeadLabelsIfViewIsOnScreen(page:Int, totalCount:Int, itemCount:Int) -> Void
}

class DataDetailBaseController: BaseController {
    weak var delegate:DataDetailControllerDelegate!
    var viewPage:Int = 0
    var totalCount:Int = 0
    var itemCount:Int = 0
    var itemId:Int = 0
    var refreshHeader:MJRefreshNormalHeader!
    var shouldUpdateData:Bool = true
    func updateDataIfNeeded() -> Void{}
    func fetchProjectDataItem() -> Void{}
}

class DataDetailDayController: DataDetailBaseController, UITableViewDelegate, UITableViewDataSource {
    var dataArray:[ProjectDataItem]? = nil
    let tableView = UITableView(frame: CGRectZero, style: .Grouped)
    override var itemId: Int{
        didSet{
            self.shouldUpdateData = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshHeader = MJRefreshNormalHeader {[unowned self] in
            self.fetchProjectDataItem()
        }
        self.refreshHeader.lastUpdatedTimeLabel.hidden = true
        self.refreshHeader.tintColor = UIColor.blackColor()
        self.tableView.mj_header = self.refreshHeader
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(DataDetailCell.self, forCellReuseIdentifier: DataDetailCell.cellIdentifier)
        self.tableView.rowHeight = DataDetailCell.cellHeight()
        self.view.addSubview(self.tableView)
        self.tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    override func updateDataIfNeeded() ->Void{
        if self.shouldUpdateData {
            self.shouldUpdateData = false
            self.refreshHeader.beginRefreshing()
        }
    }
    
    override func fetchProjectDataItem() -> Void{
        let merchant = FFMemory.sharedMemory.merchant!
        let url = String(format: KFBURL.ProjectDataItem,merchant.merchantId)
        let dateString = NSDate().fs_stringWithFormat("yyyy-MM-dd")
        self.networkManager.GET(url, parameters: ["startDate":dateString,"endDate":dateString,"itemId":"\(self.itemId)"], progress: nil, success: {[unowned self] (task, result) in
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
