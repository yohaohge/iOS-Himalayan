//
//  ButtonItem.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/8.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "ButtonItem.h"
@interface ButtonItem ()

@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UIButton *titleButton;

@end

@implementation ButtonItem

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image
{
    self = [super init];
    if (self) {
        [self.titleButton setTitle:title forState:UIControlStateNormal];
        [self.imageButton setImage:image forState:UIControlStateNormal];

    }
    return self;
}

- (UIButton *)imageButton
{
    if (!_imageButton) {
        _imageButton = [UIButton new];
        [_imageButton addTarget:self action:@selector(clickItem) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageButton;
}

- (UIButton *)titleButton
{
    if (!_titleButton) {
        _titleButton = [UIButton new];
        [_titleButton addTarget:self action:@selector(clickItem) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleButton;
}

- (void)clickItem
{
    
}
@end
