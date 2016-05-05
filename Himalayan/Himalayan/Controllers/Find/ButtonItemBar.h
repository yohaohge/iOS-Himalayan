//
//  ButtonItemBar.h
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/8.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonItemBar : UIScrollView

@property (nonatomic, assign) CGFloat itemWidth;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles iamges:(NSArray *)images;

@end
