//
//  BaseController.m
//  FddOrder
//
//  Created by ysjjchh on 14/11/24.
//  Copyright (c) 2014年 fangdd. All rights reserved.
//

#import "BaseController.h"

@interface BaseController () <UITextFieldDelegate>

@property (nonatomic, strong) UISwipeGestureRecognizer *swipe;

@end

@implementation BaseController

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self systemVersion] < 7) {
        self.view.height -= 44;
    } else {
        self.view.height -= 64;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
//    self.view.backgroundColor = UIColorWithRGBA(235, 235, 241, 1);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%@ dealloc", [self class]);
}

- (void)onSwipe {
    if (!self.navigationItem.hidesBackButton) {
        if (!self.navigationItem.hidesBackButton) {
            if (self.navigationController.viewControllers.count > 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}

- (void)removeSwipeGesture {
    if (_swipe) {
        [self.view removeGestureRecognizer:_swipe];
    }
}

- (UIButton *)showRightItemWithTitle:(NSString *)title {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 34)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
    return button;
}

- (UIButton *)showRightItemWithImage:(NSString *)imageName {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 34)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    
    return button;
}

- (UIButton *)showLeftItemWithImage:(NSString *)imageName {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 34)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    
    return button;
}

- (UIButton *)setBackItem {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 34)];
    [button setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    
    return button;
}

- (void)onBack {
    [self.navigationController popViewControllerAnimated:YES];
}







#pragma -mark UITextFieldDelegate


- (int)systemVersion {
 
    return [[[UIDevice currentDevice] systemVersion] intValue];
}


- (CGFloat)stataHeight
{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

- (CGFloat)navHeight
{
    return self.navigationController.navigationBar.frame.size.height;
    
}

@end










