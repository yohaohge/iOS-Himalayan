//
//  ItemButton.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/15.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "ItemButton.h"
 
 

@interface ItemButton ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ItemButton

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
    [self addSubview:self.imgView];
    [self addSubview:self.label];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(50));
        make.centerY.equalTo(self.mas_centerY);
    }];

    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}

- (void)setTitle:(NSString *)title
{
    self.label.text = title;
}

- (void)setImage:(UIImage *)image
{
    self.imgView.image =image;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [UIImageView new];
       
    }
    return _imgView;
}
@end
