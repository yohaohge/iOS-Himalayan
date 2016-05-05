//
//  PageScrollView.h
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/8.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewPage.h"
 

@protocol PageScrollViewDelegate <NSObject>

- (void)didScrollToIndex:(NSUInteger)index;

@end


@interface PageScrollView : UIScrollView

@property (nonatomic) NSUInteger currentIndex;

- (instancetype)initWithFrame:(CGRect)frame viewPages:(NSArray *)pages;

@property (nonatomic, weak) id<PageScrollViewDelegate> pageScrollDelegate;

@end


