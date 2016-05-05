//
//  ItemCell.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/5/3.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "MineItemCell.h"
@interface MineItemCell ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation MineItemCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self layout];
    }
    return self;
}

- (void)layout
{
    for (int i = 0; i < 4; i ++) {
        ItemView *item = [self.items objectAtIndex:i];
        [self.contentView addSubview:item];
        
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.contentView.mas_width).dividedBy(4);
            make.left.equalTo(@(kScreenWidth/4 * i));
            make.top.bottom.equalTo(self.contentView);
        }];
    }
}

- (NSArray *)items
{
    if (!_items) {
       [self createItems];
    }
    return _items;
}
- (void)createItems
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *titles = @[@"声音",@"专辑",@"关注",@"粉丝"];
    for (int i = 0; i < 4; i ++) {
        ItemView *item = [ItemView createItemWithTitle:titles[i]];
        [array addObject:item];
    }
    _items = array;
}

@end
