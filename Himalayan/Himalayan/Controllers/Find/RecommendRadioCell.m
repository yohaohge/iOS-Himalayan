//
//  RecommendRadioCell.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/18.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "RecommendRadioCell.h"
 

@interface RecommendRadioCell ()

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, copy) NSArray *titleLabels;

@end

@implementation RecommendRadioCell

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
    UIView *preView = nil;
    
    for(UIView *item in self.items)
    {
        
        [self.contentView addSubview:item];
        
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([self.items indexOfObject:item] == 0) {
                make.left.equalTo(@15);
            }
            else
            {
                make.width.equalTo(preView);
                make.left.equalTo(preView.mas_right).offset(10);
            }
            
            if ([self.items indexOfObject:item] == self.items.count - 1) {
                make.right.equalTo(@(-15));
            }
            make.height.equalTo(item.mas_width);

            
        }];
        
        preView = item;
        
        UILabel *label = [self.titleLabels objectAtIndex:[self.items indexOfObject:item]];
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(item);
            make.top.equalTo(item.mas_bottom).offset(10);
        }];
    }
}

- (NSArray *)items
{
    if (!_items) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++) {
            UIButton *item = [[UIButton alloc] init];
            [item setBackgroundImage:[UIImage imageNamed:@"liveRadioPlay_album_mask"] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:@"find_usercover"] forState:UIControlStateNormal];
            item.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 20, 10);
            [array addObject:item];
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://fdfs.xmcdn.com/group16/M01/83/15/wKgDbFYblY_ge-_uAABn8GON2wI707_web_large.jpg"] placeholderImage:[UIImage imageNamed:@"find_usercover"]];
            
            [item addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(@10);
                make.right.equalTo(@(-10));
                make.bottom.equalTo(@(-20));
            }];
            
            
        }
        _items = array;
    }
    return _items;
}

- (NSArray *)titleLabels
{
    if (!_titleLabels) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++) {
            UILabel *item = [[UILabel alloc] init];
            item.text = @"中国之声";
            item.font = [UIFont systemFontOfSize:14];
            item.textAlignment = NSTextAlignmentCenter;
            item.textColor = [UIColor grayColor];
            [array addObject:item];
        }
        _titleLabels = array;
    }
    return _titleLabels;

}

@end
