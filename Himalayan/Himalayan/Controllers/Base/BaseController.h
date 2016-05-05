//
//  BaseController.h
//  FddOrder
//
//  Created by ysjjchh on 14/11/24.
//  Copyright (c) 2014年 fangdd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrameAccessor.h"

@interface BaseController : UIViewController

@property (nonatomic, strong) UILabel *statusLabel;

- (UIButton *)showRightItemWithTitle:(NSString *)title;
- (UIButton *)showRightItemWithImage:(NSString *)imageName;
- (UIButton *)showLeftItemWithImage:(NSString *)imageName;
- (UIButton *)setBackItem;


- (void)removeSwipeGesture;

- (UITableViewCell *)tableView:(UITableView *)tableView getCellWithClassString:(NSString *)classString;
- (UITableViewCell *)tableView:(UITableView *)tableView getCellWithTitle:(NSString *)title;
- (UITableViewCell *)tableView:(UITableView *)tableView
        getCellWithClassString:(NSString *)classString
               reuseIdentifier:(NSString *)identifier;

- (CGFloat)stataHeight;
- (CGFloat)navHeight;

@end
