//
//  MerchantSwitchController.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/28.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class MerchantSwitchController: BaseController, UITableViewDelegate, UITableViewDataSource {
    var dataArray:[Merchant]?
    let identifier:String = "reuseIdentifier"
    let tableView = UITableView(frame: CGRectMake(0, 64, KFBUtility.KFBScreenWidth, KFBUtility.KFBScreenHeight-64), style: .Grouped)
    var tableRefreshHeader:MJRefreshNormalHeader!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackItem()
        
        let layer  = CALayer.linearGradientLayerWithSize(CGSizeMake(KFBUtility.KFBScreenWidth, 112))
        self.view.layer.insertSublayer(layer, atIndex: 0)
        
        self.tableRefreshHeader = MJRefreshNormalHeader {[unowned self] in
            self.fetchMerchantList()
        }
        self.tableRefreshHeader.lastUpdatedTimeLabel.hidden = true
        self.tableRefreshHeader.tintColor = UIColor.blackColor()
        self.tableView.mj_header = self.tableRefreshHeader
        
        self.tableView.backgroundColor = KFBUtility.commonBackgroundColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(MeCheckMarkCell.self, forCellReuseIdentifier: MeCheckMarkCell.cellIdentifier)
        self.tableView.rowHeight  = MeCheckMarkCell.cellHeight()
        self.view.addSubview(self.tableView)
        
        self.tableRefreshHeader.beginRefreshing()
    }
    
    func fetchMerchantList() ->Void{
        let url:String = KFBURL.MerchantListURL
        let mobile = FFMemory.sharedMemory.client!.mobile
        self.networkManager.GET(url, parameters: ["mobile":mobile], progress: nil, success: {[unowned self] (task, result) in
            guard let dic = result as? [String : AnyObject]
                else{
                    self.hud.showImage(nil, status: kNetworkError)
                    return
            }
            do{
                let resp:MerchantListResponse = try MerchantListResponse(dictionary: dic)
                if resp.success{
                    print("fetchProjectHomePageData sucess")
                    
                    self.dataArray = resp.data as? [Merchant]
                    self.tableView.reloadData()
                    if let merchant:Merchant = FFMemory.sharedMemory.merchant{
                        for i in 0..<self.dataArray!.count{
                            if self.dataArray![i].merchantId == merchant.merchantId && self.dataArray![i].merchantName == merchant.merchantName{
                                self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
                                break
                            }
                        }
                    }
                    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if self.dataArray == nil {
            return 0
        }
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.dataArray == nil {
            return 0
        }
        return self.dataArray!.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MeCheckMarkCell.cellIdentifier, forIndexPath: indexPath) as! MeCheckMarkCell
        let merchant = self.dataArray![indexPath.row]
        cell.leftText = merchant.merchantName
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let merchant = self.dataArray![indexPath.row]
        
        FFMemory.sharedMemory.merchant = merchant
        FFMemory.sharedMemory.save()
        
        NSNotificationCenter.defaultCenter().postNotificationName(kNotificationResetMerchant, object: nil)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}
