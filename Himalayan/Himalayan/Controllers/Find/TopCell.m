//
//  TopCell.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/5/4.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "TopCell.h"

@interface TopCell()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *topOneLabel;
@property (nonatomic, strong) UILabel *topTwoLabel;
@property (nonatomic, strong) UIView *separator;

@end

@implementation TopCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    [self.contentView addSubview:self.imgView];
    
    [self.imgView maskView];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@10);
        make.bottom.equalTo(@(-10));
        make.width.equalTo(self.imgView.mas_height);
    }];
    
    [self.contentView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(10);
        make.top.equalTo(self.imgView);
    }];
    
    [self.contentView addSubview:self. topOneLabel];
    
    [self. topOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.centerY.equalTo(self.imgView);
    }];
    
    [self.contentView addSubview:self.topTwoLabel];
    
    [self.topTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.imgView);
    }];
    
    [self addSubview:self.separator];
    
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.contentView);
    }];
    
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"find_kind_btn_default"];
    }
    return _imgView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"男神榜";
    }
    return _nameLabel;
}

- (UILabel *) topOneLabel
{
    if (! _topOneLabel) {
        _topOneLabel = [[UILabel alloc] init];
        _topOneLabel.text = @"1 刘德华";
        _topOneLabel.textColor = [UIColor grayColor];
        _topOneLabel.font = [UIFont systemFontOfSize:13];
    }
    return  _topOneLabel;
}

- (UILabel *)topTwoLabel
{
    if (!_topTwoLabel) {
        _topTwoLabel = [[UILabel alloc] init];
        _topTwoLabel.text = @"2 周杰伦";
        _topTwoLabel.textColor = [UIColor grayColor];
        _topTwoLabel.font = [UIFont systemFontOfSize:13];
    }
    return _topTwoLabel;
}

- (UIView *)separator
{
    if (!_separator) {
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = kLineColor;
    }
    return _separator;
}



@end
