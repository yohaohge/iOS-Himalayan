//
//  ButtonItemBar.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/8.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "ButtonItemBar.h"
@interface ButtonItemBar ()

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation ButtonItemBar

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles iamges:(NSArray *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.images = images;
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    if (self.titles && self.images && self.titles.count == self.images.count) {
        for (int i = 0; i < self.titles.count; i++) {
            UIButton *button = [[UIButton alloc] init];
            NSString *title = [self.titles objectAtIndex:i];
            UIImage *image = [self.images objectAtIndex:i];
            [button setTitle:title forState:UIControlStateNormal];
            [button setImage:image forState:UIControlStateNormal];
        }
    }
}

- (void)layoutSubviews
{
    
}

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}






@end
