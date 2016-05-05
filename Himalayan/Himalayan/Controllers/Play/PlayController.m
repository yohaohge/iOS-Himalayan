//
//  PlayController.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/17.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "PlayController.h"

@interface PlayController ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation PlayController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *leftBtn = [self setBackItem];
    [leftBtn setImage:[UIImage imageNamed:@"playingback"] forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"playingback_h"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

    UIButton *rightBtn = [self showRightItemWithImage:@"icon_more_n"];
    [rightBtn setImage:[UIImage imageNamed:@"icon_more_h"] forState:UIControlStateNormal];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back
{
    [self dismissViewControllerAnimated:self completion:^{
        
    }];
}

//- (UILabel *)titleLabel
//{
//}

@end
