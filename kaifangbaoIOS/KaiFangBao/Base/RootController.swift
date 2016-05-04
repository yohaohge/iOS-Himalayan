//
//  ViewController.swift
//  KaiFangBao
//
//  Created by ysjjchh on 16/3/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class RootController: BaseController, UITableViewDataSource, UITableViewDelegate {
    
    var table: UITableView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "home"
        
        table = UITableView(frame: self.view.bounds, style: .Grouped)
        table.dataSource = self
        table.delegate = self
        table.setupEmptyView()
        
        self.view.addSubview(table)
        
        dispatch_after(2.0.dispatchTime, dispatch_get_main_queue()) {
            self.table.reloadData()
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func loginTest() {
        
    }
}

