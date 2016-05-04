//
//  ProjectTableController.swift
//  KaiFangBao
//
//  Created by fdd_zhangou on 16/4/14.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

protocol ProjectTableControllerDelegate:NSObjectProtocol {
    func didClickProjectTableItem(house:House) -> Void
    func reloadHouseList() -> Void
}

class ProjectTableController: UITableViewController {
    var dataArray:[House]?{
        didSet{
            if !self.tableView.mj_header.hidden {
                self.tableView.mj_header.endRefreshing()
            }
            if dataArray == nil {
                return
            }
            self.tableView.reloadData()
            if let house:House = FFMemory.sharedMemory.house{
                for i in 0..<dataArray!.count{
                    if dataArray![i].houseId == house.houseId && dataArray![i].houseName == house.houseName{
                        self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: i, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
                        break
                    }
                }
            }
        }
    }
    weak var DataDetailDelegate:ProjectTableControllerDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.clipsToBounds = true
        self.tableView.registerClass(ProjectCheckMarkCell.self, forCellReuseIdentifier: ProjectCheckMarkCell.cellIdentifier)
        self.tableView.rowHeight = ProjectCheckMarkCell.cellHeight()
        let header = MJRefreshNormalHeader {[unowned self] in
            self.DataDetailDelegate.reloadHouseList()
        }
        header.lastUpdatedTimeLabel.hidden = true
        header.tintColor = UIColor.blackColor()
        self.tableView.mj_header = header
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        guard (self.dataArray != nil) else{
            return 0
        }
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard (self.dataArray != nil) else{
            return 0
        }
        return self.dataArray!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ProjectCheckMarkCell.cellIdentifier, forIndexPath: indexPath) as! ProjectCheckMarkCell
        let house = self.dataArray![indexPath.row]
        cell.leftText = house.houseName
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let house = self.dataArray![indexPath.row]
        self.DataDetailDelegate.didClickProjectTableItem(house)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}
