//
//  ClassificationPage.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/11.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "ClassificationPage.h"
#import "FindKindView.h"
#import "ItemCell.h"

@interface ClassificationPage () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FindKindView *findKindView;
@end



@implementation ClassificationPage


#pragma -mark UITableViewDelegate UITableViewDataSource

- (FindKindView *)findKindView
{
    if (!_findKindView) {
        _findKindView = [[FindKindView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
    }
    return _findKindView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.findKindView;
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }

    }
    return _tableView;
}

- (UIView *)view
{
    return self.tableView;
}

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
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return 1;
    }
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCell *cell = [[ItemCell alloc] init];
    cell.leftTitle = [self titles][indexPath.section*3+indexPath.row][0];
    cell.rightTitle = [self titles][indexPath.section*3+indexPath.row][1];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins =  UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return cell?cell:[UITableViewCell new];
}

- (NSArray *)titles
{
    return @[@[@"3D体验馆",@"脱口秀"],
             @[@"资讯",@"情感生活"],
             @[@"历史人文",@"外语"],
             
             @[@"教育培训",@"名校公开课"],
             @[@"百家讲坛",@"广播剧"],
             @[@"吸取",@"电台"],
             
             @[@"商业财经",@"IT科技"],
             @[@"健身养生",@"校园"],
             @[@"汽车",@"旅游"],
             
             @[@"电影",@"ACG"]
             
             ];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
