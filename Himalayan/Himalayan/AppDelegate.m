//
//  AppDelegate.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/6.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "FindController.h"
#import "SoundViewController.h"
#import "PlayController.h"
#import "MineController.h"
#import "DownloadController.h"
@interface AppDelegate ()

@property (nonatomic, strong) TabBarViewController *tabBarController;
@property (nonatomic, strong) FindController *findViewController;
@property (nonatomic, strong) SoundViewController *soundViewController;
@property (nonatomic, strong) UIViewController *playViewController;
@property (nonatomic, strong) DownloadController *downloadViewController;
@property (nonatomic, strong) MineController *mineViewController;
@property (nonatomic, strong) UINavigationController *findRootViewController;
@property (nonatomic, strong) UINavigationController *soundRootViewController;
@property (nonatomic, strong) UINavigationController *downloadRootViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //启动
    
    self.window.rootViewController = self.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (TabBarViewController *)tabBarController
{
    if (!_tabBarController) {
        _tabBarController = [[TabBarViewController alloc] init];
        _tabBarController.viewControllers = @[self.findRootViewController, self.soundRootViewController,self.playViewController,self.downloadRootViewController,self.mineViewController];
        UIButton *button = [_tabBarController addCenterButtonWithImage:[UIImage imageNamed:@"tabbar_np_normal"] selectedImage:[UIImage imageNamed:@"tabbar_np_normal"]];
        _tabBarController.view.backgroundColor = [UIColor whiteColor];
        
        UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        [playButton setImage:[UIImage imageNamed:@"tabbar_np_play"  ] forState:UIControlStateNormal];
        [button addSubview:playButton];
         playButton.center = CGPointMake(button.frame.size.width / 2, button.frame.size.height / 2);
        [_tabBarController.tabBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor]]];
        [_tabBarController.tabBar setShadowImage:[self imageWithColor: [UIColor clearColor]]];
        _tabBarController.tabBar.layer.shadowColor = [UIColor grayColor].CGColor;
        _tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0 , -2);
        _tabBarController.tabBar.layer.shadowOpacity =0.8;

        CALayer *imageLayer = [CALayer layer];
        imageLayer.contents = (id)[UIImage imageNamed:@"tabbar_np_shadow"].CGImage;
        imageLayer.frame = CGRectMake(-3, -3, button.bounds.size.width + 6, button.bounds.size.height + 6);
        [button.layer addSublayer:imageLayer];
        
        CALayer *playImageLayer = [CALayer layer];
        playImageLayer.contents = (id)[UIImage imageNamed:@"tabbar_np_playshadow"].CGImage;
        playImageLayer.frame = playButton.bounds;
        [playButton.layer addSublayer:playImageLayer];
        
        [playButton addTarget:self action:@selector(onPlay) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _tabBarController;
}

- (FindController *)findViewController
{
    if (!_findViewController) {
        _findViewController = [[FindController alloc] init];
    }
    return _findViewController;
}

- (SoundViewController *)soundViewController
{
    if (!_soundViewController) {
        _soundViewController = [[SoundViewController alloc] init];
    }
    return _soundViewController;
}

- (UIViewController *)playViewController
{
    if (!_playViewController) {
        _playViewController = [[UIViewController alloc] init];
    }
    return _playViewController;
}

- (DownloadController *)downloadViewController
{
    if (!_downloadViewController) {
        _downloadViewController = [[DownloadController alloc] init];

    }
    return _downloadViewController;
}

- (MineController *)mineViewController
{
    if (!_mineViewController) {
        _mineViewController = [[MineController alloc] init];
        _mineViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:@"tabbar_me_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_me_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
        
        _mineViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);
    }
    return _mineViewController;
}

- (UINavigationController *)findRootViewController
{
    if (!_findRootViewController) {
        _findRootViewController = [[UINavigationController alloc] initWithRootViewController:self.findViewController];
        _findRootViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:@"tabbar_find_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_find_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        _findRootViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);
    }
    return _findRootViewController;
}
- (UINavigationController *)soundRootViewController
{
    if (!_soundRootViewController) {
        _soundRootViewController = [[UINavigationController alloc] initWithRootViewController:self.soundViewController];
        _soundRootViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:@"tabbar_sound_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_sound_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
        _soundRootViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);

    }
    return _soundRootViewController;
}

- (UINavigationController *)downloadRootViewController
{
    if (!_downloadRootViewController) {
        _downloadRootViewController = [[UINavigationController alloc] initWithRootViewController:self.downloadViewController];
        _downloadRootViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:@"tabbar_download_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_download_h"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ];
        _downloadRootViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);
        
    }
    return _downloadRootViewController;
}



- (UIImage *)imageWithColor:(UIColor *)color {
    
    CGSize imageSize = CGSizeMake(2, 2);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    
    [color set];
    
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    
    UIImage *colorImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return colorImg;
}

#pragma -mark event

- (void)onPlay
{
    PlayController *vc =[[PlayController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];

    
    UIViewController *selectedController = self.tabBarController.selectedViewController;
    
    [self.tabBarController presentViewController:nav animated:YES completion:^{
        
    }];
   
}
@end
