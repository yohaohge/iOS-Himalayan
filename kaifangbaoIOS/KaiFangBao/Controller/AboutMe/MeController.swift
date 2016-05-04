//
//  MeController.swift
//  KaiFangBao
//
//  Created by fdd_zhangou on 16/4/12.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class MeController: BaseController,UITableViewDelegate,UITableViewDataSource {
    let dataArray:Array<[(String,String)]> = [[],[("个人消息","0")],[("合作商列表","0")],[("反馈",""),("当前版本","1.0版本")],[]]
    var tableView :UITableView!
    let gradientLayerHeight:CGFloat = 64+112+44+5
    let gradientLayer:CALayer = CALayer.radialGradientLayerWithSize(CGSizeMake(KFBUtility.KFBScreenWidth, 64+112+44+5))
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.insertSublayer(self.gradientLayer, atIndex: 0)
        self.configureTableView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return MeHeaderCell.cellHeight()
        case 3:
            return MeExitCell.cellHeight()
        default:
            return MeBaseCell.cellHeight()
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(MeHeaderCell.cellIdentifier, forIndexPath: indexPath) as! MeHeaderCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(MeRightRedDotCell.cellIdentifier, forIndexPath: indexPath) as! MeRightRedDotCell
            cell.showFullSeparator(true)
            cell.showHeaderSeparator(true)
            let data = self.dataArray[indexPath.section][indexPath.row]
            cell.leftText = data.0
            cell.rightCountText = data.1
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(MeRightRedDotCell.cellIdentifier, forIndexPath: indexPath) as! MeRightRedDotCell
            cell.showFullSeparator(true)
            cell.showHeaderSeparator(true)
            let data = self.dataArray[indexPath.section][indexPath.row]
            cell.leftText = data.0
            cell.rightCountText = data.1
            return cell
        case 3:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier(MeRightIndicatorCell.cellIdentifier, forIndexPath: indexPath) as! MeRightIndicatorCell
                let data = self.dataArray[indexPath.section][indexPath.row]
                cell.leftText = data.0
                cell.showHeaderSeparator(true)
                cell.showFullSeparator(false)
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier(MeRightVersionCell.cellIdentifier, forIndexPath: indexPath) as! MeRightVersionCell
                let data = self.dataArray[indexPath.section][indexPath.row]
                cell.leftText = data.0
                cell.rightText = data.1
                cell.showFullSeparator(true)
                return cell
            }
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier(MeExitCell.cellIdentifier, forIndexPath: indexPath) as! MeExitCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0{
            let tempCell = cell as! MeHeaderCell
            tempCell.name = FFMemory.sharedMemory.client!.userName
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier(UITableViewHeaderFooterView.cellIdentifier)
        view!.contentView.backgroundColor = KFBUtility.commonBackgroundColor
        return view
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 1 {
            let controller = MessageController()
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
        
        if indexPath.section == 2 && indexPath.row == 0 {
            let controller = MerchantSwitchController()
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
        
        if indexPath.section == 3 && indexPath.row == 0 {
            let layer = CALayer.linearGradientLayerWithSize(CGSizeMake(self.view.bounds.width, 112))
            let controller  = UMFeedbackViewController2(nibName: "UMFeedbackViewController", bundle: nil)
            controller.gradientLayer = layer
            controller.appkey = "5620983c67e58e7c77001c57"
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
    
        if indexPath.section == 4 {
            let controller = LoginController()
            controller.tabController = self.tabBarController
            self.tabBarController!.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let y:CGFloat = -scrollView.contentOffset.y
        //限制下拉,高度与头部cell高度相同
        if y>112{
            scrollView.contentOffset = CGPointMake(0, -112)
            return
        }
        //等比缩放背景渐变层,渐变层缩放加速度要大于下拉加速度
        if y > 0 {
            var height:CGFloat = self.gradientLayerHeight+y*8
            if height > self.tableView.height {
                height = self.tableView.height
            }
            let scale = height/self.gradientLayerHeight
            self.gradientLayer.setAffineTransform(CGAffineTransformMakeScale(scale,scale))
        }
    }
    
    func configureTableView() -> Void{
        self.tableView = UITableView.init(frame: CGRectMake(0, 64, KFBUtility.KFBScreenWidth, KFBUtility.KFBScreenHeight-64-49), style: .Grouped)
        
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorStyle = .None
        
        self.tableView.registerClass(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: UITableViewHeaderFooterView.cellIdentifier)
        
        self.tableView.registerClass(MeHeaderCell.self, forCellReuseIdentifier: MeHeaderCell.cellIdentifier)
        self.tableView.registerClass(MeRightRedDotCell.self, forCellReuseIdentifier: MeRightRedDotCell.cellIdentifier)
        self.tableView.registerClass(MeRightIndicatorCell.self, forCellReuseIdentifier: MeRightIndicatorCell.cellIdentifier)
        self.tableView.registerClass(MeRightVersionCell.self, forCellReuseIdentifier: MeRightVersionCell.cellIdentifier)
        self.tableView.registerClass(MeExitCell.self, forCellReuseIdentifier: MeExitCell.cellIdentifier)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
    }

}
