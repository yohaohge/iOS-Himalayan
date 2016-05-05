//
//  FDSegment.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/7.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "FDSegment.h"
#import "NSString+Extension.h"

@interface FDSegment ()

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) UIView *indicator;
@property (nonatomic, strong) UIView *separation;
@property (nonatomic) CGFloat height;

@end

@implementation FDSegment

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentSize = frame.size;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (void)layoutSubviews
{
    if (self.titles){
        //添加分割线
        if (!self.separation.superview) {
            [self addSubview:self.separation];
            self.separation.frame = CGRectMake(0, self.height - 0.5, self.frame.size.width, 0.5);
        }
        
        //添加items
        CGFloat x = 0;
        for (int i = 0; i < self.titles.count; i++)
        {
            UIButton *item = [self itemAtIndex:i];
            if (!item.superview )
            {
                [self addSubview:item];
            }
            item.frame = CGRectMake(x, 0, [self widthForItemAtIndex:i], self.height - self.heightForIndicator);
            x += item.frame.size.width;
        }
        //调整contentSize
        self.contentSize = CGSizeMake(x, self.frame.size.height);
        
        //添加
        UIView *selectedItem = [self itemAtIndex:self.seletedIndex];
        CGFloat centerX = selectedItem.center.x;
        if (!self.indicator.superview)
        {
            [self addSubview:self.indicator];
            UIButton *firstItem = [self.items objectAtIndex:0];
            firstItem.selected = YES;
        }
        self.indicator.frame = CGRectMake(centerX - [self widthForIndicatorAtIndex:self.seletedIndex]/2 , self.height - self.heightForIndicator, [self widthForIndicatorAtIndex:self.seletedIndex] ,self.heightForIndicator);
    }
}

- (CGFloat)widthForItemAtIndex:(NSUInteger)index
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(segment:widthForItemAtIndex:)])
    {
        return [self.dataSource segment:self widthForItemAtIndex:index];
    }
    
    return self.frame.size.width/self.titles.count;
}

- (CGFloat)widthForIndicatorAtIndex:(NSUInteger)index
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(segment:widthForIndicatorAtIndex:)])
    {
        return [self.dataSource segment:self widthForIndicatorAtIndex:index];
    }
    UIButton *item = [self.items objectAtIndex:index];
    NSString *title = [self.titles objectAtIndex:index];
    UIFont *font = [item.titleLabel font];
    return [self string:title sizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width + 2;
}

- (CGFloat)heightForIndicator
{
    if (_heightForIndicator > 0) {
        return _heightForIndicator;
    }
    return 2;
}

- (void)setSeletedIndex:(NSUInteger)seletedIndex
{
    if (seletedIndex >= self.items.count) {
        NSLog(@"seletedIndex out of beyond");
        return;
    }
    _seletedIndex = seletedIndex;

    for (int i = 0; i < self.titles.count; i++) {
        
        UIButton *item = [self itemAtIndex:i];
        if (_seletedIndex == item.tag)
        {
            item.selected = YES;
        }
        else
        {
            item.selected = NO;
        }
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        
        UIView *selectedItem = [self itemAtIndex:_seletedIndex];
        CGFloat centerX = selectedItem.center.x;
        if (!self.indicator.superview)
        {
            [self addSubview:self.indicator];
        }
        self.indicator.frame = CGRectMake(centerX - [self widthForIndicatorAtIndex:_seletedIndex]/2 , self.height - self.heightForIndicator, [self widthForIndicatorAtIndex:_seletedIndex] ,self.heightForIndicator);
        
    }];
    
}



#pragma -mark 

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

- (NSMutableArray *)titles
{
    if (!_titles) {
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(titlesForSegment:)])
        {
            _titles = [[self.dataSource titlesForSegment:self] mutableCopy];
        }
        else
        {
            NSLog(@"must set titles for segment");
        }
    }
    return _titles;
}

- (UIView *)indicator
{
    if (!_indicator) {
        _indicator = [[UIView alloc] init];
        _indicator.backgroundColor = [UIColor redColor];//默认颜色
    }
    return _indicator;
}

- (UIButton *)itemAtIndex:(NSUInteger)index
{
    if (index >= self.items.count) {
        UIButton *item = [[UIButton alloc] init];
        [item setTitle:[self.titles objectAtIndex:index] forState:UIControlStateNormal];
        [item setTitle:[self.titles objectAtIndex:index] forState:UIControlStateSelected];
        [item setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [item setTitleColor:self.selectedColor forState:UIControlStateSelected];
        [item addTarget:self action:@selector(selectedItem:) forControlEvents:UIControlEventTouchUpInside];
        item.titleLabel.font = self.font;
        item.tag = index;
        [self.items addObject:item];
    }
    return  [self.items objectAtIndex:index];

}

- (UIView *)separation
{
    if (!_separation) {
        _separation = [[UIView alloc] init];
        _separation.backgroundColor = [UIColor grayColor];
    }
    return _separation;
}
- (void)selectedItem:(UIButton *)item
{
    self.seletedIndex = item.tag;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segment:didSelectedItemAtIndex:)])
    {
        [self.delegate segment:self didSelectedItemAtIndex:self.seletedIndex];
    }
}
- (void)reloadData
{
    self.titles = nil;
}

- (UIColor *)selectedColor
{
    if (!_selectedColor) {
        _selectedColor = [UIColor redColor];
    }
    return _selectedColor;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

-(CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
