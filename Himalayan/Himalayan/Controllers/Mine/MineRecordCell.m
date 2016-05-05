//
//  MineRecordCell.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/5/3.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "MineRecordCell.h"

@interface MineRecordCell ()

@property (nonatomic, strong) UIButton *recordButton;


@end

@implementation MineRecordCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView addSubview:self.recordButton];
    
    [self.recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}

- (UIButton *)recordButton
{
    if (!_recordButton) {
        _recordButton = [[UIButton alloc] init];
        [_recordButton setImage:[UIImage imageNamed:@"btn_record_n"
                                 ] forState:UIControlStateNormal];
        [_recordButton setImage:[UIImage imageNamed:@"btn_record_h"
                                 ] forState:UIControlStateNormal];
        
        
    }
    return _recordButton;
}

@end
