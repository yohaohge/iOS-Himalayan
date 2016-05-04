//
//  DataDetailTableController.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/17.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

protocol DataDetailTableControllerDelegate:NSObjectProtocol {
    func didClickDataDetailTableControllerItem(indexPath:NSIndexPath) -> Void
}

class DataDetailTableController: UITableViewController {
    weak var DataDetailDelegate:DataDetailTableControllerDelegate!
    var dataArray:Array<(String,[String])>!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = KFBUtility.commonBackgroundColor
        self.tableView.clipsToBounds = true
        self.tableView.registerClass(KFBTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: KFBTableViewHeaderFooterView.cellIdentifier)
        self.tableView.registerClass(DataDetailCheckMarkCell.self, forCellReuseIdentifier: DataDetailCheckMarkCell.cellIdentifier)
        self.tableView.rowHeight = DataDetailCheckMarkCell.cellHeight()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.dataArray.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataArray[section].1.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataArray[section].0
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return KFBTableViewHeaderFooterView.cellHeight()
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier(KFBTableViewHeaderFooterView.cellIdentifier)
        view?.contentView.backgroundColor = KFBUtility.commonBackgroundColor
        return view
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(DataDetailCheckMarkCell.cellIdentifier, forIndexPath: indexPath) as! DataDetailCheckMarkCell
        cell.leftText = self.dataArray[indexPath.section].1[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.DataDetailDelegate.didClickDataDetailTableControllerItem(indexPath)
    }
}
