//
//  SpecailCell.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/9.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "SpecailCell.h"
#import "SpecialItem.h"
 

@interface SpecailCell ()

@property (nonatomic, copy) NSArray *items;

@end

@implementation SpecailCell

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
                make.left.equalTo(preView.mas_right).offset(15);
            }
            
            if ([self.items indexOfObject:item] == self.items.count - 1) {
                make.right.equalTo(@(-15));
            }
            
        }];
        
        preView = item;
    }
}

- (NSArray *)items
{
    if (!_items) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++) {
            SpecialItem *item = [[SpecialItem alloc] init];
            [array addObject:item];
        }
        _items = array;
    }
    return _items;
}

@end
