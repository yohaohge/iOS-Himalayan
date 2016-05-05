//
//  MineHeaderView.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/5/3.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "MineHeaderView.h"
 

@interface MineHeaderView ()

@property (nonatomic, strong) UIButton *setButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *avatarButton;
@property (nonatomic, strong) UIView *coverView;

@end

@implementation MineHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self addSubview:self.bgView];
    [self addSubview:self.setButton];
    [self addSubview:self.shareButton];
    [self addSubview:self.avatarButton];
    
    self.bgView.frame = CGRectMake(0, -100, kScreenWidth, 300);

    
    [self.setButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@40);
    }];
    
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(20));
        make.top.equalTo(@40);
    }];
    
    [self.avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.setButton);
    }];
    
    self.avatarButton.layer.cornerRadius = self.avatarButton.width/2;
    self.avatarButton.layer.masksToBounds = YES;
//    self.bgView.transform = CGAffineTransformMakeScale(2, 2);
}

- (UIButton *)setButton
{
    if (!_setButton) {
        _setButton = [[UIButton alloc] init];
        [_setButton setImage:[UIImage imageNamed:@"icon_setting"] forState:UIControlStateNormal];
        [_setButton setImage:[UIImage imageNamed:@"icon_setting_h"] forState:UIControlStateHighlighted];

    }
    return _setButton;
}

- (UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [[UIButton alloc] init];
        [_shareButton setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
        [_shareButton setImage:[UIImage imageNamed:@"icon_share_h"] forState:UIControlStateHighlighted];
    }
    return _shareButton;
}

- (UIButton *)avatarButton
{
    if (!_avatarButton) {
        _avatarButton = [[UIButton alloc] init];
        [_avatarButton setImage:[UIImage imageNamed:@"find_radio_default"] forState:UIControlStateNormal];
        [_avatarButton setImage:[UIImage imageNamed:@"find_radio_default"] forState:UIControlStateHighlighted];    }
    return _avatarButton;
}

- (UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.image = [UIImage imageNamed:@"3.jpg"];
        _bgView.alpha = 0.5;
        _bgView.backgroundColor = [UIColor grayColor];
        [_bgView addSubview:self.coverView];
        [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.width.height.equalTo(_bgView);
        }];

    }
    return _bgView;
}

- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = [UIColor grayColor];
        _coverView.alpha = 0.5;
    }
    return _coverView;
}
@end
