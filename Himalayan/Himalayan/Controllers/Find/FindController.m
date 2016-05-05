//
//  FindController.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/7.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "FindController.h"
#import "FDSegment.h"
 #import "BaseViewPage.h"
#import "PageScrollView.h"
#import "RecommendationPage.h"
#import "ClassificationPage.h"
#import "BroadcastPage.h"
#import "AnchorPage.h"
#import "TopPage.h"

@interface FindController () <UITableViewDelegate, UITableViewDataSource,FDSegmentDataSource,FDSegmentDelegate,PageScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FDSegment *segment;
@property (nonatomic, strong) RecommendationPage *recommendationPage;
@property (nonatomic, strong) ClassificationPage *classificationPage;
@property (nonatomic, strong) AnchorPage *anchorPage;
@property (nonatomic, strong) TopPage *topPage;
@property (nonatomic, strong) BroadcastPage *broadcastPage;
@property (nonatomic, strong) PageScrollView *pageScrollView;

@end

@implementation FindController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"发现"];
    UIButton *rightButton = [self showRightItemWithImage:@"icon_search_n"];
    [rightButton setImage:[UIImage imageNamed:@"icon_search_h"] forState:UIControlStateHighlighted];
    
    [self.view addSubview:self.segment];
    self.navigationController.title = @"";
    [self.view addSubview:self.pageScrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (FDSegment *)segment
{
    if (!_segment) {
        _segment = [[FDSegment alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 38)];
        _segment.font = [UIFont systemFontOfSize:14];
        _segment.delegate = self;
        _segment.dataSource = self;
    }
    return _segment;
}
- (RecommendationPage *)recommendationPage
{
    if (!_recommendationPage) {
        _recommendationPage = [RecommendationPage new];
    }
    return _recommendationPage;
}

- (ClassificationPage *)classificationPage
{
    if (!_classificationPage) {
        _classificationPage = [ClassificationPage new];
    }
    return _classificationPage;
}

- (BroadcastPage *)broadcastPage
{
    if (!_broadcastPage) {
        _broadcastPage = [BroadcastPage new];
    }
    return _broadcastPage;
}

- (AnchorPage *)anchorPage
{
    if (!_anchorPage) {
        _anchorPage = [AnchorPage new];
    }
    return _anchorPage;
}

- (TopPage *)topPage
{
    if (!_topPage) {
        _topPage = [TopPage new];
    }
    return _topPage;
}

- (PageScrollView *)pageScrollView
{
    if (!_pageScrollView) {
        CGRect frame = CGRectMake(0, self.segment.height, self.view.width, self.view.height - self.segment.height - self.tabBarController.tabBar.height);
        _pageScrollView = [[PageScrollView alloc] initWithFrame:frame viewPages:@[self.recommendationPage,self.classificationPage,self.broadcastPage,self.topPage,self.anchorPage]];
        _pageScrollView.pageScrollDelegate = self;
    }
    return _pageScrollView;
}
#pragma -mark FDSegmentDataSource
- (NSArray *)titlesForSegment:(FDSegment *)segment
{
    return @[@"推荐",@"分类",@"广播",@"榜单",@"主播"];
}

//- (CGFloat)segment:(FDSegment *)segment widthForIndicatorAtIndex:(NSInteger)index
//{
//    return kScreenWidth/5;
//}

- (CGFloat)segment:(FDSegment *)segment widthForItemAtIndex:(NSInteger)index
{
    return kScreenWidth/5;
}



#pragma -mark FDSegmentDelegate

- (void)segment:(FDSegment *)segment didSelectedItemAtIndex:(NSUInteger)index
{
    self.pageScrollView.currentIndex = index;
}

- (void)didScrollToIndex:(NSUInteger)index
{
    self.segment.seletedIndex = index;
}


@end
