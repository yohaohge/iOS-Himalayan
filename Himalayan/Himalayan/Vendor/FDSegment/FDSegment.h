//
//  FDSegment.h
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/7.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDSegment;

// this represents the display and behaviour of the items.
@protocol  FDSegmentDataSource<NSObject>

- (NSArray *)titlesForSegment:(FDSegment *)segment;
- (CGFloat)segment:(FDSegment *)segment widthForItemAtIndex:(NSInteger)index;
- (CGFloat)segment:(FDSegment *)segment widthForIndicatorAtIndex:(NSInteger)index;

@end

@protocol  FDSegmentDelegate<NSObject>

@optional
- (void)segment:(FDSegment *)segment didSelectedItemAtIndex:(NSUInteger)index;

@end

@protocol FDSegmentDataSource;
@protocol FDSegmentDelegate;

@interface FDSegment : UIScrollView

@property (nonatomic) NSUInteger seletedIndex;
@property (nonatomic) CGFloat heightForIndicator;

@property (nonatomic, weak)   id<FDSegmentDataSource> dataSource;
@property (nonatomic, weak)   id<FDSegmentDelegate> delegate;

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, strong) UITableView *tableView;


- (void)reloadData;

@end
