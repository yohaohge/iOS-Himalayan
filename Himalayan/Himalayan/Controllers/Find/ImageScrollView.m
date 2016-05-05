//
//  ImageScrollView.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/8.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "ImageScrollView.h"

@interface ImageScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageViews;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ImageScrollView

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setImageViewsWithImages:images];
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = YES;
    
    for (int i = 0; i < self.imageViews.count; i++) {
        UIImageView *page = [self.imageViews objectAtIndex:i];
        [self addSubview:page];
        page.frame = self.bounds;
        page.x = self.width * i;
        page.backgroundColor = [UIColor redColor];
    }
    self.contentSizeWidth = self.width * self.imageViews.count;
    
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];

}
- (void)dealloc
{
    [self.timer invalidate];
}

- (void)setImageViewsWithImages:(NSArray *)images
{
    if (images.count > 0) {
        for (id image in images) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:image]];

            [self.imageViews addObject:imageView];
        }
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[images firstObject]];
        [self.imageViews addObject:imageView];
        
        UIImageView *last = [[UIImageView alloc] init];
        [last sd_setImageWithURL:[images firstObject]];

        [self.imageViews insertObject:last atIndex:0];

    }
}

- (NSMutableArray *)imageViews
{
    if (!_imageViews) {
        _imageViews = [[NSMutableArray alloc] init];
    }
    return _imageViews;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.contentOffsetX == scrollView.contentSizeWidth - self.width)
    {
        [scrollView setContentOffset:CGPointMake(self.width, 0) animated:NO];
    }
    if (scrollView.contentOffsetX == 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentSizeWidth - 2*self.width, 0) animated:NO];
    }
   
}

- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil  repeats:YES];
    }
    return _timer;
}

- (void)nextPage
{
    [self setContentOffset:CGPointMake(self.contentOffsetX + self.width, 0) animated:YES];
}
@end
