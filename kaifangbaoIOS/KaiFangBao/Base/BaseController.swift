//
//  BaseController.swift
//  KaiFangBao
//
//  Created by ysjjchh on 16/3/23.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import Foundation

class BaseController: UIViewController {
    
    lazy var hud: WSProgressHUD = {
        let _hud = WSProgressHUD(view: self.view)
        self.view.addSubview(_hud)
        return _hud
    }()
    
    let networkManager:AFHTTPSessionManager = {
        let network = AFHTTPSessionManager()
        network.requestSerializer = AFJSONRequestSerializer()
        network.requestSerializer.timeoutInterval = 20
        network.requestSerializer.setValue(ClientSwift().UserAgetStringSwift(), forHTTPHeaderField: "User-Agent")
        network.responseSerializer = AFJSONResponseSerializer()
        network.responseSerializer.acceptableContentTypes = Set<String>(["text/html", "application/json", "text/plain"])
        return network
    }()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.resetHTTPHeader), name: kNotificationLoginSuccess, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.cancelRequests()
        NSNotificationCenter.defaultCenter().removeObserver(self)
        print("\(self.classForCoder) dealloc")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = KFBUtility.commonBackgroundColor
        self.automaticallyAdjustsScrollViewInsets = false
        
        if kIsIpad {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(BaseController.onSwipe))
            gesture.direction = .Right
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    func resetHTTPHeader() -> Void{
        let p = ClientSwift()
        print(p)
        self.networkManager.requestSerializer.setValue(ClientSwift().UserAgetStringSwift(), forHTTPHeaderField: "User-Agent")
    }
    
    func onSwipe() {
        
        if !self.navigationItem.hidesBackButton &&
            self.navigationController?.viewControllers.count > 1 {
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func cancelRequests() {
        self.networkManager.operationQueue.cancelAllOperations()
        self.networkManager.session.invalidateAndCancel()
    }
    
    func showRightItemWithTitle(title: String) -> UIButton {
        let button = UIButton(frame: CGRectMake(0, 0, 60, 34))
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitle(title, forState: .Normal)
        button.contentHorizontalAlignment = .Right
        
        let item = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = item
        
        return button
    }
    
    func showRightItemWithImage(image: UIImage) -> UIButton {
        let button = UIButton(frame: CGRectMake(0, 0, 60, 34))
        button.setImage(image, forState: .Normal)
        button.contentHorizontalAlignment = .Right
        
        let item = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = item
        
        return button
    }
    
    func showLeftItemWithImage(image: UIImage) -> UIButton {
        let button = UIButton(frame: CGRectMake(0, 0, 60, 34))
        button.setImage(image, forState: .Normal)
        button.contentHorizontalAlignment = .Left
        
        let item = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = item
        
        return button
    }
    
    func setBackItem() {
        let button = self.showLeftItemWithImage(UIImage(named: "ic_back")!)
        button.addTarget(self, action: #selector(self.onBack), forControlEvents: .TouchUpInside)
    }
    
    func onBack() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}












