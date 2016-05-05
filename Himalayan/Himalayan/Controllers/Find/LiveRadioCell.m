//
//  LiveRadioCell.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/21.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "LiveRadioCell.h"
#import "ImageScrollView.h"
 

@interface LiveRadioCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *separator;
@property (nonatomic, strong) UIButton *playButton;

@end

@implementation LiveRadioCell

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
    
    [self.contentView addSubview:self.stateLabel];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.centerY.equalTo(self.imgView);
    }];
    
    [self.contentView addSubview:self.detailLabel];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.imgView);
    }];
    
    [self.contentView addSubview:self.separator];
    
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.playButton];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.centerY.equalTo(self.contentView);
    }];
    
    
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [_imgView sd_setImageWithURL:[NSURL URLWithString:@"http://fdfs.xmcdn.com/group10/M01/88/9E/wKgDaVYmaFXi0WNqAADGj2hAjb0761_web_large.jpg"] placeholderImage:[UIImage imageNamed:@"find_kind_btn_default"]];
    }
    return _imgView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"经济之声";
    }
    return _nameLabel;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc] init];
        _stateLabel.text = @"直播中:财经夜读";
        _stateLabel.font = [UIFont systemFontOfSize:14];
    }
    return _stateLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.text = @"收听人数:10.3万";
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.font = [UIFont systemFontOfSize:12];
    }
    return _detailLabel;
}

 - (UIView *)separator
{
    if (!_separator) {
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = kLineColor;
    }
    return _separator;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [[UIButton alloc] init];
        [_playButton setImage:[UIImage imageNamed:@"liveRadioCellPlay"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"liveRadioCellPause"] forState:UIControlStateSelected];

    }
    return _playButton;
}

@end
