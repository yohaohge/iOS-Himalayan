//
//  RecommendationPage.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/8.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "RecommendationPage.h"
#import "ImageScrollView.h"
#import "SectionTitleCell.h"
#import "SpecailCell.h"

@interface RecommendationPage () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ImageScrollView *imageScrollView;

@end

@implementation RecommendationPage

- (UIView *)view
{
    return self.tableView;
}

-  (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.imageScrollView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (ImageScrollView *)imageScrollView
{
    if (!_imageScrollView) {
        _imageScrollView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 170) images:@[@"http://fdfs.xmcdn.com/group7/M02/58/06/wKgDWlcjE9KC_6rSABQ1b9l2nCE454.jpg",@"http://fdfs.xmcdn.com/group7/M03/58/04/wKgDWlcjEdTR2mVCABRmB1MJySg613.jpg",@"http://fdfs.xmcdn.com/group14/M08/5D/13/wKgDZFcoZVbjZengABbLOH5peAs109.jpg"]];
    }
    return _imageScrollView;
}
#pragma -mark UITableViewDataSource


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 44;
    }
    else
    {
        return kScreenWidth/3 + 45;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 14;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section > 0  )  {
        if(indexPath.row == 0)
        {
            cell = [[SectionTitleCell alloc] init];
            ((SectionTitleCell *)cell).title = [self titles][indexPath.section];
        }
        else
        {
            cell = [[SpecailCell alloc] init];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell?cell:[UITableViewCell new];
}

- (NSArray *)titles
{
    return @[@"小编推荐",
             @"精品听单",
             @"听新闻",
             @"听小说",
             @"听脱口秀",
             @"听娱乐",
             @"听相声",
             @"听音乐",
             @"听情感心声",
             @"听历史",
             @"听公开课",
             @"听广播剧",
             @"听儿童故事",
             @"听旅游"
             ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
