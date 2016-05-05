//
//  SpecialItem.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/9.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "SpecialItem.h"
 

@interface SpecialItem ()

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *specialLabel;
@property (nonatomic, strong) UIImageView *specialImageView;

@end

@implementation SpecialItem
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
    [self addSubview:self. imgView];
    [self addSubview:self.itemLabel];
    [self addSubview:self.specialImageView];
    [self addSubview:self.specialLabel];

    [self. imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(self. imgView.mas_width);
    }];
    
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self. imgView.mas_bottom).offset(10);
        make.left.right.equalTo(self. imgView);
        make.height.lessThanOrEqualTo(@100);
    }];
    
    
    [self.specialImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self. imgView);
        make.top.equalTo(self.itemLabel.mas_bottom).offset(5);
    }];
    
    [self.specialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.specialImageView.mas_right).offset(2);
        make.centerY.equalTo(self.specialImageView);
    }];
    
}

- (UIImageView *) imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:@"http://fdfs.xmcdn.com/group15/M00/15/AE/wKgDaFVueQmRMkIhAAHt8MMrL-U286_web_large.jpg"] placeholderImage:[UIImage imageNamed:@"find_usercover"]];
    }
    return _imgView;
}
- (UIImageView *)specialImageView
{
    if (!_specialImageView) {
        _specialImageView = [[UIImageView alloc] init];
        [_specialImageView setImage:[UIImage imageNamed:@"find_specialicon"]];
    }
    return _specialImageView;
}

- (UILabel *)itemLabel
{
    if (!_itemLabel) {
        _itemLabel = [[UILabel alloc] init];
        _itemLabel.numberOfLines = 2;
        _itemLabel.text = @"职场没有欢乐颂：关关才争对错，安迪只看利弊！";
        _itemLabel.font = [UIFont systemFontOfSize:14];

           }
    return _itemLabel;
}

- (UILabel *)specialLabel
{
    if (!_specialLabel) {
        _specialLabel = [[UILabel alloc] init];
        _specialLabel.text = @"老汪谈职场";
        _specialLabel.font = [UIFont systemFontOfSize:12];
        _specialLabel.textColor = [UIColor grayColor];

    }
    return _specialLabel;
}
@end
