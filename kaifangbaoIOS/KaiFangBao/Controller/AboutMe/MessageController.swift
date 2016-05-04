//
//  MessageController.swift
//  KaiFangBao
//
//  Created by fdd_zhangou on 16/4/14.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class MessageController: BaseController,UITableViewDataSource,UITableViewDelegate {

    let tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRectZero, style: .Grouped)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "个人消息"
        self.setBackItem()
        
        let layer = CAGradientLayer.linearGradientLayerWithSize(CGSizeMake(self.view.bounds.width, 112))
        self.view.layer.insertSublayer(layer, atIndex: 0)
        
        self.tableView.frame = CGRectMake(0, 64, KFBUtility.KFBScreenWidth, KFBUtility.KFBScreenHeight-64)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.setupEmptyView()
        self.view.addSubview(self.tableView)
        
        dispatch_after(0.1.dispatchTime, dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell()
        return cell
    }
    
}
