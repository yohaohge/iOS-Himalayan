//
//  LoginController.swift
//  KaiFangBao
//
//  Created by fdd_zhangou on 16/4/12.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITableViewDelegate,UIAlertViewDelegate{
    lazy var hud: WSProgressHUD = {
        let _hud = WSProgressHUD(view: self.view)
        self.view.addSubview(_hud)
        return _hud
    }()
    
    var networkManager:AFHTTPSessionManager = {
        let network = AFHTTPSessionManager()
        network.requestSerializer = AFJSONRequestSerializer()
        network.requestSerializer.timeoutInterval = 20
        network.responseSerializer = AFJSONResponseSerializer()
        network.responseSerializer.acceptableContentTypes = Set<String>(["text/html", "application/json", "text/plain"])
        return network
    }()
    
    deinit {
        self.cancelRequests()
        NSNotificationCenter.defaultCenter().removeObserver(self)
        print("\(self.classForCoder) dealloc")
    }
    func cancelRequests() {
        self.networkManager.operationQueue.cancelAllOperations()
        self.networkManager.session.invalidateAndCancel()
    }
    weak var tabController:UITabBarController!
    var mobileText:String{
        get{
            return self.mobileFiled.text!
        }
    }
    var passwdText:String{
        get{
            return self.passwdFiled.text!
        }
    }
    let scrollView:UIScrollView = UIScrollView(frame:UIScreen.mainScreen().bounds)
    
    let imageView:UIImageView = {
        let im = UIImageView(image: UIImage(named: "Icon-76"))
        im.backgroundColor = UIColor.clearColor()
        im.layer.cornerRadius = 16
        im.layer.masksToBounds = true
        return im
    }()
    let imageLabel:UILabel = {
        let label = UILabel()
        label.text = "房云宝合作商版"
        label.font = UIFont.systemFontOfSize(18)
        label.textAlignment = .Center
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        return label
    }()
    
    let mobileFiled:UITextField = {
        let tempField = UITextField()
        tempField.keyboardType = .NumberPad
        tempField.tintColor = UIColor.whiteColor()
        tempField.font = UIFont.sansProFontOfSize(17)
        tempField.backgroundColor = UIColor.clearColor()
        tempField.textColor = UIColor.whiteColor()
        tempField.attributedPlaceholder = NSAttributedString(string: "请输入手机号码", attributes: [NSForegroundColorAttributeName:UIColor(white: 0.8, alpha: 0.7)])
        return tempField
    }()
    
    let passwdFiled:UITextField = {
        let tempField = UITextField()
        tempField.keyboardType = .NumberPad
        tempField.tintColor = UIColor.whiteColor()
        tempField.font = UIFont.sansProFontOfSize(17)
        tempField.backgroundColor = UIColor.clearColor()
        tempField.textColor = UIColor.whiteColor()
        tempField.attributedPlaceholder = NSAttributedString(string: "验证码", attributes: [NSForegroundColorAttributeName:UIColor(white: 0.8, alpha: 0.7)])
        return tempField
    }()
    
    let verifyBtn:UIButton = {
        let btn = UIButton(type:UIButtonType.Custom)
        btn.titleLabel?.font = UIFont.systemFontOfSize(16)
        btn.backgroundColor = UIColor.clearColor()
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.setTitle("获取验证码", forState: .Normal)
        return btn
    }()
    
    let loginBtn:UIButton = {
        let btn = UIButton(type:UIButtonType.System)
        btn.backgroundColor = UIColor.whiteColor()
        btn.setTitle("登录", forState: .Normal)
        btn.setTitleColor(KFBUtility.selectedColor, forState: .Normal)
        btn.layer.cornerRadius = 4.0
        return btn
    }()
    
    let padding:CGFloat = 15
    weak var tickDownTimer:NSTimer?
    var tickDownCount:Int = 15
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let layer = CALayer.radialGradientLayerWithSize(self.view.bounds.size)
        self.view.layer.insertSublayer(layer, atIndex: 0)
        
        self.layoutViews()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self
            , action: #selector(self.tapBackgroundToHideKeyboard))
        self.scrollView.addGestureRecognizer(tap)
        
        self.imageView.userInteractionEnabled = true
        let changeTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.changeServer))
        changeTap.numberOfTapsRequired = 6
        self.imageView.addGestureRecognizer(changeTap)
        
        self.mobileFiled.addTarget(self, action: #selector(self.textFiledDidChange(_:)), forControlEvents: .EditingChanged)
        self.passwdFiled.addTarget(self, action: #selector(self.textFiledDidChange(_:)), forControlEvents: .EditingChanged)
        
        self.verifyBtn.addTarget(self, action: #selector(self.verify), forControlEvents: .TouchUpInside)
        
        self.loginBtn.enabled = false
        self.loginBtn.alpha = 0.6
        self.loginBtn.addTarget(self, action: #selector(self.login), forControlEvents: .TouchUpInside)
        
        //键盘处理
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        //reset http header
        FFMemory.sharedMemory.reset()
        let client = ClientSwift()
        self.networkManager.requestSerializer.setValue(client.UserAgetStringSwift(), forHTTPHeaderField: "User-Agent")
    }
    
    func changeServer() -> Void{
        let alert:UIAlertView = UIAlertView(title: "输入IP", message: "输入IP后点击\"测试\",切换到指定IP,点击\"线上\",切换到线上环境", delegate: nil, cancelButtonTitle: "线上", otherButtonTitles: "测试")
        alert.alertViewStyle = .PlainTextInput
        alert.textFieldAtIndex(0)?.text = kTestAddress
        alert.delegate = self
        alert.show()
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0{
            FFMemory.sharedMemory.serverAddress = kServerAddress
        }else if buttonIndex == 1{
            FFMemory.sharedMemory.serverAddress = alertView.textFieldAtIndex(0)!.text!
        }
    }
    
    func tapBackgroundToHideKeyboard() -> Void{
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(info:NSNotification) -> Void{
        let rect:CGRect =  (info.userInfo?[UIKeyboardFrameEndUserInfoKey])!.CGRectValue
        
        if self.view.height - loginBtn.bottom < (rect.size.height + 8) {
            let y = (rect.size.height + 8) - (self.view.height - self.loginBtn.bottom)
            self.scrollView.setContentOffset(CGPointMake(0, y), animated: true)
        }
    }
    
    func keyboardWillHide(info:NSNotification) ->Void{
        if self.scrollView.contentOffsetY != 0 {
            self.scrollView.setContentOffset(CGPointZero, animated: true)
        }
    }
    
    func verify() ->Void{
        if self.mobileFiled.text?.characters.count > 0  {
            self.mobileFiled.resignFirstResponder()
            self.passwdFiled.becomeFirstResponder()
            self.fetchMessageVerifyCode()
        }else{
            self.hud.showImage(nil,status: "请输入手机号码")
        }
    }
    func fetchMessageVerifyCode() -> Void{
        self.verifyBtn.userInteractionEnabled = false
        let mobileNumber = self.mobileFiled.text!
        self.networkManager.GET(KFBURL.SmsCodeURL, parameters: ["mobile":mobileNumber], progress: nil, success: {[unowned self] (task, result) in
            
            guard let dic = result as? [String : AnyObject]
                else{
                    self.hud.showImage(nil, status: kNetworkError)
                    return
            }
            print(dic)
            do{
                let resp:SMSResponse = try SMSResponse(dictionary: dic)
                if resp.success{
                    self.hud.showImage(nil, status: "发送成功")
                    self.verifyBtn.setTitle("15s后重发", forState: .Normal)
                    self.tickDownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(self.beginWaitingForResendingMessage), userInfo: nil, repeats: true)
                }else{
                    self.hud.showImage(nil, status: resp.msg)
                }
            }catch _{
                self.hud.showImage(nil, status: kNetworkError)
            }
            
        }) {[unowned self] (task, error) in
            print(error.localizedDescription)
            self.hud.showImage(nil, status: kNetworkError)
        }
    }
    
    func beginWaitingForResendingMessage() ->Void{
        self.tickDownCount -= 1
        self.verifyBtn.setTitle("\(self.tickDownCount)s后重发", forState: .Normal)
        if self.tickDownCount <= 0 {
            self.verifyBtn.userInteractionEnabled = true
            self.tickDownTimer?.invalidate()
            self.tickDownCount = 15
            self.verifyBtn.setTitle("获取验证码", forState: .Normal)
        }
    }
    
    func textFiledDidChange(textFiled:UITextField) ->Void{
        
        if self.passwdFiled.text?.characters.count>0 && self.mobileFiled.text?.characters.count > 0{
            self.loginBtn.enabled = true
            self.loginBtn.alpha = 1.0
        }else{
            self.loginBtn.enabled = false
            self.loginBtn.alpha = 0.6
        }
    }
    
    func login() ->Void{
        if self.passwdFiled.text?.characters.count>0 && self.mobileFiled.text?.characters.count > 0{
            self.view.endEditing(true)
        }else{
            return
        }
        self.hud.showWithString("登录中...")
        self.networkManager.GET(KFBURL.LoginURL, parameters: ["mobile":"\(self.mobileText)","code":"\(self.passwdText)"], progress: nil, success:
            {[unowned self] (task, result) in
                
                guard let dic = result as? [String : AnyObject]
                    else{
                        self.hud.showImage(nil, status: kNetworkError)
                        return
                }
                do{
                    let resp:LoginResponse = try LoginResponse(dictionary: dic)
                    if resp.success{
                        self.handleLoginResult(resp.data)
                    }else{
                        self.hud.showImage(nil, status: resp.msg)
                    }
                }catch _{
                    self.hud.showImage(nil, status: kNetworkError)
                }
                
        }) {[unowned self] (task, error) in
            print(error.localizedDescription)
            self.hud.showImage(nil, status: kNetworkError)
        }
    }
    func handleLoginResult(user:User) -> Void{
        self.hud.showSuccessWithString("登录成功")
        dispatch_async(dispatch_get_global_queue(0, 0)) {
            let tempClient:ClientSwift = ClientSwift()
            tempClient.userName = user.userName
            tempClient.mobile = user.mobile
            tempClient.sessionToken = user.token
            
            //默认选择第一个合作商身份
            var merchent:Merchant?
            if user.merchants.count>0{
                merchent = user.merchants.first as? Merchant
            }else{
                merchent = Merchant()
            }
            
            FFMemory.sharedMemory.isLogin = true
            FFMemory.sharedMemory.client = tempClient
            FFMemory.sharedMemory.merchant = merchent
            FFMemory.sharedMemory.save()
            NSNotificationCenter.defaultCenter().postNotificationName(kNotificationLoginSuccess, object: nil)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC*1)), dispatch_get_main_queue(), {
                let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appdelegate.networkManager.requestSerializer.setValue(ClientSwift().UserAgetStringSwift(), forHTTPHeaderField: "User-Agent")
                if self.presentingViewController == self.tabController {
                    self.tabController.selectedIndex = 1
                    self.dismissViewControllerAnimated(true, completion: nil)
                }else{
                    self.tabController.modalTransitionStyle = .CrossDissolve
                    self.presentViewController(self.tabController, animated: true, completion: nil)
                }
            })
        }
    }
    
    func layoutViews() ->Void{
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.imageView)
        self.imageView.snp_makeConstraints { (make) in
            make.width.height.equalTo(90)
            make.centerX.equalTo(self.scrollView)
            make.top.equalTo(90)
        }
        
        self.scrollView.addSubview(self.imageLabel)
        self.imageLabel.snp_makeConstraints { (make) in
            make.width.lessThanOrEqualTo(self.scrollView)
            make.height.equalTo(18)
            make.centerX.equalTo(self.scrollView)
            make.top.equalTo(self.imageView.snp_bottom).offset(15)
        }
        
        let mobileContainer = UIView()
        mobileContainer.layer.borderColor = UIColor.whiteColor().CGColor
        mobileContainer.layer.borderWidth = 0.5
        mobileContainer.layer.cornerRadius = 4.0
        self.scrollView.addSubview(mobileContainer)
        mobileContainer.snp_makeConstraints { (make) in
            make.width.equalTo(KFBUtility.KFBScreenWidth-self.padding*2)
            make.left.equalTo(self.padding)
            make.height.equalTo(48)
            make.top.equalTo(self.imageLabel.snp_bottom).offset(61)
        }
        
        mobileContainer.addSubview(self.mobileFiled)
        self.mobileFiled.snp_makeConstraints { (make) in
            make.left.equalTo(mobileContainer).offset(self.padding)
            make.right.equalTo(mobileContainer).offset(-self.padding)
            make.height.equalTo(40)
            make.centerY.equalTo(mobileContainer).offset(2)
        }
        
        let passwdContainer = UIView()
        passwdContainer.layer.borderColor = UIColor.whiteColor().CGColor
        passwdContainer.layer.borderWidth = 0.5
        passwdContainer.layer.cornerRadius = 4.0
        self.scrollView.addSubview(passwdContainer)
        passwdContainer.snp_makeConstraints { (make) in
            make.width.equalTo(KFBUtility.KFBScreenWidth-self.padding*2)
            make.height.equalTo(48)
            make.left.equalTo(self.padding)
            make.top.equalTo(mobileContainer.snp_bottom).offset(10)
        }
        
        let separator = UIView()
        separator.backgroundColor = UIColor.whiteColor()
        
        passwdContainer.addSubview(self.passwdFiled)
        passwdContainer.addSubview(separator)
        passwdContainer.addSubview(self.verifyBtn)
        self.passwdFiled.snp_makeConstraints { (make) in
            make.left.equalTo(passwdContainer).offset(self.padding)
            make.width.equalTo(passwdContainer.snp_width).offset(-100-self.padding)
            make.height.equalTo(40)
            make.centerY.equalTo(passwdContainer).offset(2)
        }
        separator.snp_makeConstraints { (make) in
            make.width.equalTo(0.5)
            make.height.equalTo(passwdContainer)
            make.left.equalTo(self.passwdFiled.snp_right)
            make.top.equalTo(passwdContainer)
        }
        
        self.verifyBtn.snp_makeConstraints { (make) in
            make.left.equalTo(separator.snp_right)
            make.top.bottom.right.equalTo(passwdContainer)
        }
        
        self.scrollView.addSubview(self.loginBtn)
        self.loginBtn.snp_makeConstraints { (make) in
            make.width.equalTo(KFBUtility.KFBScreenWidth-self.padding*2)
            make.height.equalTo(48)
            make.left.equalTo(self.padding)
            make.top.equalTo(passwdContainer.snp_bottom).offset(40)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
