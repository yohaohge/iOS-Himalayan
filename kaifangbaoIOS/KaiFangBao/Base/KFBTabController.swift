//
//  KFBTabController.swift
//  KaiFangBao
//
//  Created by wuhongshuai on 16/4/23.
//  Copyright © 2016年 fangdd. All rights reserved.
//

import UIKit

class KFBTabController: UITabBarController {
    let projectNaviController:FFNavigationController  = {
        let navi = FFNavigationController(rootViewController: ProjectController())
        navi.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navi.navigationBar.shadowImage = UIImage()
        navi.navigationBar.translucent = true
        navi.tabBarItem = UITabBarItem(title: "项目", image: UIImage(named:"ic_project_normal")!.imageWithRenderingMode(.AlwaysOriginal), selectedImage: UIImage(named:"ic_project_press")!.imageWithRenderingMode(.AlwaysOriginal))
        return navi
    }()
    
    let gatherNaviController:FFNavigationController  = {
        let navi = FFNavigationController(rootViewController: GatherController())
        navi.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navi.navigationBar.shadowImage = UIImage()
        navi.navigationBar.translucent = true
        navi.tabBarItem = UITabBarItem(title: "汇总", image: UIImage(named:"ic_gather_normal")!.imageWithRenderingMode(.AlwaysOriginal), selectedImage: UIImage(named:"ic_gather_press")!.imageWithRenderingMode(.AlwaysOriginal))
        return navi
    }()
    
    let meNaviController:FFNavigationController = {
        let navi = FFNavigationController(rootViewController: MeController())
        navi.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navi.navigationBar.shadowImage = UIImage()
        navi.navigationBar.translucent = true
        navi.tabBarItem = UITabBarItem(title: "我", image: UIImage(named:"ic_me_normal")!.imageWithRenderingMode(.AlwaysOriginal), selectedImage: UIImage(named:"ic_me_press")!.imageWithRenderingMode(.AlwaysOriginal))
        return navi
    }()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.tabBar.opaque = true
        self.tabBar.backgroundColor = UIColor.whiteColor()
        self.tabBar.translucent = false
        self.viewControllers = [projectNaviController, gatherNaviController,meNaviController]
        self.selectedIndex = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
