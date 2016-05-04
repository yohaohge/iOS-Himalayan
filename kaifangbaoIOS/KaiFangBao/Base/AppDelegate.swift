//
//  AppDelegate.swift
//  KaiFangBao
//
//  Created by ysjjchh on 16/3/22.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let tabController:KFBTabController = KFBTabController()
    
    let networkManager:AFHTTPSessionManager = {
        let _network = AFHTTPSessionManager()
        _network.requestSerializer = AFJSONRequestSerializer()
        _network.requestSerializer.timeoutInterval = 20
        let str:String = ClientSwift().UserAgetStringSwift()
        _network.requestSerializer.setValue(str, forHTTPHeaderField: "User-Agent")
        _network.responseSerializer = AFJSONResponseSerializer()
        _network.responseSerializer.acceptableContentTypes = Set<String>(["text/html", "application/json", "text/plain"])
        return _network
    }()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        if !FFMemory.sharedMemory.isLogin {
            let controller = LoginController()
            controller.tabController = self.tabController
            window?.rootViewController = controller
        }else{
            print(FFMemory.sharedMemory.client)
            window?.rootViewController = self.tabController
        }
        window?.makeKeyAndVisible()
        self.checkVersion()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        FFMemory.sharedMemory.save()
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        FFMemory.sharedMemory.save()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        FFMemory.sharedMemory.save()
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        //远程通知处理（push）
        print(userInfo.description)
        
        if  !(FFMemory.sharedMemory.isLogin) {
            return
        }
       
    }
    
    func sendTokenToServer() -> Void {
        
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func checkVersion()  {
        
        let info:[String : AnyObject]? = NSBundle.mainBundle().infoDictionary
        let version:String = info!["CFBundleShortVersionString"] as! String;
        let url = "http://api.fir.im/apps/latest/\(kAppKey)?api_token=\(kFirAPIToken)&type=ios"


        self.networkManager.GET(url, parameters: nil, progress: nil, success: {(task, result) in

            guard let dic = result as? [String : AnyObject]
                else{
//                    self.hud.showImage(nil, status: kNetworkError)
                    return
            }
            do
            {
                let resp:AppInfoResponse = try AppInfoResponse(dictionary: dic)

                if  ((version.compare(resp.version as String)) == .OrderedAscending) {
                    //更新
                    
                    let alert = UIAlertView();
                    alert.title = "有新版本啦！";
                    alert.message = resp.changelog;
//                    if([array[1] intValue] == 1)
//                    {
                    alert.addButtonWithTitle("更新")
                    alert.showWithCompleteHandler({ (index:NSInteger) in
                        UIApplication .sharedApplication().openURL(NSURL.init(string: resp.update_url)!)
                    })
//                        [alert showWithCompleteHandler:^(NSInteger index) {
//                        [FSUtility openUrl:path];
//                        exit(0);
//                        }];
//                    } else if (!_hasShowUpdateAlready) {
//                        _hasShowUpdateAlready = YES;
//                        [alert addButtonWithTitle:@"取消"];
//                        [alert addButtonWithTitle:@"更新"];
//                        [alert showWithCompleteHandler:^(NSInteger index) {
//                        if (1 == index) {
//                        [FSUtility openUrl:path];
//                        exit(0);
//                        }
//                        }];
//                    }

                }
                
                
            }
            catch _{
//                self.hud.showImage(nil, status: kNetworkError)
            }
            
            }, failure: {
                (task, error) in
                print(error.localizedDescription)
//                self.hud.showImage(nil, status: kNetworkError)
        })
        

    }
}
