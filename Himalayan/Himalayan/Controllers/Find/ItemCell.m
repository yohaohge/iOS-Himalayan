//
//  ItemCell.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/11.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "ItemCell.h"
 
#import "ItemButton.h"

@interface ItemCell ()

@property (nonatomic, strong) ItemButton *firstButton;
@property (nonatomic, strong) ItemButton *secondButton;
@property (nonatomic, strong) UIView *centerLine;

@end

@implementation ItemCell

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!(self.firstButton.superview)) {
        [self.contentView addSubview:self.firstButton];
        [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.contentView);
            make.width.equalTo(self.contentView).dividedBy(2);
        }];
    }
    
    if (!(self.secondButton.superview)) {
        [self.contentView addSubview:self.secondButton];
        [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self.contentView);
            make.width.equalTo(self.contentView).dividedBy(2);
        }];
    }
    
    if (!(self.centerLine.superview)) {
        [self.contentView addSubview:self.centerLine];
        
        [self.centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@8);
            make.bottom.equalTo(@(-8));
            make.width.equalTo(@0.5);
            make.centerX.equalTo(self.contentView);
        }];
    }

}

- (ItemButton *)firstButton
{
    if (!_firstButton) {
        _firstButton = [[ItemButton alloc] init];
        [_firstButton setTitle:@"--" ];
    }
    return _firstButton;
}

- (ItemButton *)secondButton
{
    if (!_secondButton) {
        _secondButton = [[ItemButton alloc] init];
        [_secondButton setTitle:@"--"];
    }
    return _secondButton;
}

- (UIView *)centerLine
{
    if (!_centerLine) {
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = [UIColor grayColor];
    }
    return _centerLine;
}

- (void)setLeftTitle:(NSString *)leftTitle
{
    [self.firstButton setTitle:leftTitle];
}

- (void)setLeftImage:(UIImage *)leftImage
{
    [self.firstButton setImage:leftImage];
}

- (void)setRightImage:(UIImage *)rightImage
{
    [self.secondButton setImage:rightImage];
}

- (void)setRightTitle:(NSString *)rightTitle
{
    [self.secondButton setTitle:rightTitle];
}

@end
