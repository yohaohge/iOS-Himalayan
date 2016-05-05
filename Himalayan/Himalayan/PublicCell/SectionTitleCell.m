//
//  SectionTitleCell.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/9.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "SectionTitleCell.h"
 

@interface SectionTitleCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreButton;

@end

@implementation SectionTitleCell

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.moreButton];

    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(5);
        make.centerY.equalTo(self.imgView);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(@(-15));
    }];
    
}
- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"findsection_logo"];
    }
    return _imgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setImage:[UIImage imageNamed:@"liveRadioSectionMore_Normal"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"liveRadioSectionMore_High"] forState:UIControlStateHighlighted];
    }
    return _moreButton;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setShowMoreButton:(BOOL)showMoreButton
{
    self.moreButton.hidden = !showMoreButton;
}

@end
