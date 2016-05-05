//
//  TabBarViewController.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/6.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(UIButton *) addCenterButtonWithImage:(UIImage*)buttonImage selectedImage:(UIImage*)selectedImage
{
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.button addTarget:self action:@selector(pressChange:) forControlEvents:UIControlEventTouchUpInside];
    self.button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //  设定button大小为适应图片
    self.button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [self.button setImage:buttonImage forState:UIControlStateNormal];
    [self.button setImage:selectedImage forState:UIControlStateSelected];
    
    //  这个比较恶心  去掉选中button时候的阴影
    self.button.adjustsImageWhenHighlighted=NO;
    
    
    /*
     *  核心代码：设置button的center 和 tabBar的 center 做对齐操作， 同时做出相对的上浮
     */
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        self.button.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        self.button.center = center;
    }
    
    [self.view addSubview:self.button];
    return self.button;
}

//-(void)pressChange:(id)sender
//{
//    self.selectedIndex=2;
//    self.button.selected=YES;
//}

#pragma mark- TabBar Delegate

//  换页和button的状态关联上
//
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    if (self.selectedIndex==2) {
//        self.button.selected=YES;
//    }else
//    {
//        self.button.selected=NO;
//    }
//}
@end
