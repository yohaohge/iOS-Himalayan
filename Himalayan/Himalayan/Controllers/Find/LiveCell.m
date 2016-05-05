//
//  LiveCell.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/16.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "LiveCell.h"
 
 

@interface LiveCell ()

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *items;

@end

@implementation LiveCell

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
                make.left.equalTo(@20);
            }
            else
            {
                make.width.equalTo(preView);
                make.left.equalTo(preView.mas_right).offset(20);
            }
            
            if ([self.items indexOfObject:item] == self.items.count - 1) {
                make.right.equalTo(@(-20));
            }
//            make.height.equalTo(item.mas_width);
            make.centerY.equalTo(self.contentView);
            
        }];
        
        preView = item;
    }
}

- (NSArray *)items
{
    if (!_items) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.imageArray.count; i++) {
            UIButton *item = [[UIButton alloc] init];
            [item setImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
            [array addObject:item];
        }
        _items = array;
    }
    return _items;
}


- (NSArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = @[@"liveLocal",@"liveCountry",@"liveProvince",@"liveNet"];
    }
    
    return _imageArray;
}
@end
