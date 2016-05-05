//
//  DownloadController.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/5/4.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "DownloadController.h"
#import "FDSegment.h"

@interface DownloadController ()<FDSegmentDataSource,FDSegmentDelegate>

@property (nonatomic, strong) FDSegment *segment;

@end

@implementation DownloadController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.segment];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark getters
- (FDSegment *)segment
{
    if (!_segment) {
        _segment = [[FDSegment alloc] initWithFrame:CGRectMake(0, [self stataHeight], kScreenWidth, [self navHeight])];
        _segment.dataSource = self;
        _segment.delegate = self;
        _segment.font = [UIFont systemFontOfSize:18];
    }
    return _segment;
}

#pragma -mark FDSegmentDataSource

- (NSArray *)titlesForSegment:(FDSegment *)segment
{
    return @[@"专辑",@"声音",@"下载中"];
}

- (CGFloat)segment:(FDSegment *)segment widthForIndicatorAtIndex:(NSInteger)index
{
    return kScreenWidth/3;
}

- (CGFloat)segment:(FDSegment *)segment widthForItemAtIndex:(NSInteger)index
{
    return kScreenWidth/3;
}

@end
