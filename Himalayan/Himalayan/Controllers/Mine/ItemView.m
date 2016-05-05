//
//  ItemView.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/5/3.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "ItemView.h"
@interface ItemView ()

@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ItemView

- (UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        
    }
    return _numLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

+ (instancetype)createItemWithTitle:(NSString *)title
{
    ItemView *itemView = [[ItemView alloc] init];
    
    [itemView addSubview:itemView.titleLabel];
    [itemView addSubview:itemView.numLabel];
    
    itemView.titleLabel.text = title;
    itemView.numLabel.text = @"0";
    
    [itemView.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(itemView);
        make.top.equalTo(@10);
    }];
    
    [itemView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(itemView);
        make.top.equalTo(itemView.numLabel.mas_bottom);
    }];
    return itemView;
}
@end
