//
//  PageScrollView.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/8.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "PageScrollView.h"

@interface PageScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *pages;

@end

@implementation PageScrollView

- (instancetype)initWithFrame:(CGRect)frame viewPages:(NSArray *)pages
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pages = pages;
        self.delegate = self;
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = YES;
    
    for (int i = 0; i < self.pages.count; i++) {
        BaseViewPage *page = [self.pages objectAtIndex:i];
        if ([page isKindOfClass:[BaseViewPage class]]) {
            [self addSubview:page.view];
            page.view.frame = self.bounds;
            page.view.x = self.width * i;
        }
        else
        {
            NSLog(@"pages must contains the array of BaseViewPage");
            break;
        }
    }
    self.contentSizeWidth = self.width * self.pages.count;
}

- (void)setCurrentIndex:(NSUInteger)currentIndex
{
    _currentIndex = currentIndex;
    if (currentIndex < self.pages.count ) {
        self.contentOffsetX = self.width * currentIndex;
    }
    else
    {
        NSLog(@"currentIndex beyond pages array range");
    }
}

#pragma -mark
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentIndex = (scrollView.contentOffsetX + self.width/2) / self.width;
    if (self.pageScrollDelegate && [self.pageScrollDelegate respondsToSelector:@selector(didScrollToIndex:)]) {
        [self.pageScrollDelegate didScrollToIndex:_currentIndex];
    }

}
@end
