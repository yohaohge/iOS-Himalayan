//
//  MineController.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/5/3.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "MineController.h"
#import "MineHeaderView.h"
#import "MineItemCell.h"
#import "MineRecordCell.h"

@interface MineController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MineHeaderView *headerView;

@end

@implementation MineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark tableViewDelegate and tableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        MineItemCell *cell = [[MineItemCell alloc] init];
        return cell;
    }
    if(indexPath.section == 0 && indexPath.row == 1)
    {
        MineRecordCell *cell = [[MineRecordCell alloc] init];
        cell.backgroundColor = self.tableView.backgroundColor;

        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.imageView.image = [[self images] objectAtIndex:indexPath.section][indexPath.row];;
    cell.textLabel.text = [[self titles] objectAtIndex:indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 0.001;
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0 && indexPath.section == 0)
    {
        return 60;
    }
    if(indexPath.row == 1 && indexPath.section == 0)
    {
        return 80;
    }
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
        case 1:
            return 1;
        case 2:
            return 3;
        case 3:
            return 2;
        case 4:
            return 2;
        case 5:
            return 5;

        default:
            return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (-scrollView.contentOffsetY > 100) {
        self.headerView.bgView.top =  scrollView.contentOffsetY;
        self.headerView.bgView.height = 200 - scrollView.contentOffsetY;
        

    }
    else
    {
        self.headerView.bgView.top = -100 ;
        self.headerView.bgView.height = 300 ;
    }

}

#pragma -mark get_ and set_
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (MineHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    }
    return _headerView;
}

- (NSArray *)titles
{
    return @[
             @[@"",@"",@"主播管理中心"],
             @[@"消息中心"],
             @[@"我的订阅",@"播放历史",@"赞过的"],
             @[@"喜马拉雅商城",@"我的商城订单"],
             @[@"游戏中心",@"智能硬件设备"],
             @[@"免流量服务",@"找听友",@"账号绑定",@"意见反馈",@"设置"],
             ];
}

- (NSArray *)images
{
    return @[
             @[@"",@"",[UIImage imageNamed:@"me_setting_usercenter"]],
             @[[UIImage imageNamed:@"me_setting_sixin"]],
             @[[UIImage imageNamed:@"me_setting_favAlbum"],[UIImage imageNamed:@"me_setting_playhis"],[UIImage imageNamed:@"me_setting_liked"] ],
             @[[UIImage imageNamed:@"me_setting_usercenter@3x"],[UIImage imageNamed:@"me_setting_usercenter@3x"]],
             @[[UIImage imageNamed:@"me_setting_game"],[UIImage imageNamed:@"me_setting_device"]],
             @[[UIImage imageNamed:@"me_setting_union"],[UIImage imageNamed:@"me_setting_findting"],[UIImage imageNamed:@"me_setting_social"],[UIImage imageNamed:@"me_setting_feedback"],[UIImage imageNamed:@"me_setting_setting"]],
             ];
}

@end
