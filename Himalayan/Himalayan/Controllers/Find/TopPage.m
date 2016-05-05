//
//  TopPage.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/5/4.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "TopPage.h"
#import "SectionTitleCell.h"
#import "TopCell.h"

@interface TopPage ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TopPage
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        }
        
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
        }
        
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        
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
    if (indexPath.section == 0) {
        return 115;
    }

    if (indexPath.row > 0) {
        return 80;
    }
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 2;
        case 2:
            return 10;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0:
        {
//            cell = [[LiveCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
            
        }
        case 1:
        {
            if (indexPath.row == 0) {
                cell = [[SectionTitleCell alloc] init];
                ((SectionTitleCell *)cell).title = @"节目榜单";
                ((SectionTitleCell *)cell).showMoreButton = NO;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            else
            {
                cell = [[TopCell alloc] init];
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow"]];
            }
            break;
        }
        case 2:
        {
            if (indexPath.row == 0) {
                cell = [[SectionTitleCell alloc] init];
                ((SectionTitleCell *)cell).title = @"主播榜单";
                ((SectionTitleCell *)cell).showMoreButton = NO;

            }
            else
            {
                cell = [[TopCell alloc] init];
                cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_arrow"]];
            }
            
            break;
        }
        default:
            break;
    }

    
    return cell?:[[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
