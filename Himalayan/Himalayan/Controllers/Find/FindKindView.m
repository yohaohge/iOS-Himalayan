//
//  FindKindView.m
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/11.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import "FindKindView.h"
@interface FindKindView ()

@property (nonatomic, strong) NSArray *btnArray;

@end

@implementation FindKindView

- (void)layoutSubviews
{
    UIButton *firstButton = [self.btnArray firstObject];
    if (!firstButton.superview) {
        [self addSubview:firstButton];
    }
    
    
    [firstButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@10);
        make.right.equalTo(self.mas_centerX).offset(-5);
        make.height.equalTo(firstButton.mas_width);

    }];
    
    UIView *secondButton = [self.btnArray objectAtIndex:1];
    if (!secondButton.superview) {
        [self addSubview:secondButton];
        [secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(firstButton);
            make.left.equalTo(firstButton.mas_right).offset(5);
        }];
    }
    
    UIView *thirdButton = [self.btnArray objectAtIndex:2];
    if (!thirdButton.superview) {
        [self addSubview:thirdButton];
        [thirdButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(firstButton);
            make.left.equalTo(secondButton.mas_right).offset(5);
            make.right.equalTo(@(-10));
            make.width.equalTo(secondButton);

        }];
    }
    
    UIView *forthButton = [self.btnArray objectAtIndex:3];
    if (!forthButton.superview) {
        [self addSubview:forthButton];
        [forthButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(secondButton.mas_bottom).offset(5);
            make.left.equalTo(firstButton.mas_right).offset(5);
            make.height.equalTo(secondButton);
            make.bottom.equalTo(firstButton);
            make.right.equalTo(secondButton);
        }];
    }
    
    UIView *fifthButton = [self.btnArray objectAtIndex:4];
    if (!fifthButton.superview) {
        [self addSubview:fifthButton];
        [fifthButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(forthButton);
            make.left.equalTo(forthButton.mas_right).offset(5);
            make.bottom.equalTo(firstButton);
            make.height.equalTo(thirdButton);
            make.right.equalTo(@(-10));

        }];
    }
    
}



- (NSArray *)btnArray
{
    if (!_btnArray) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 5; i++) {
            UIButton *btn = [[UIButton alloc] init];
            [btn setBackgroundImage: [UIImage imageNamed:@"find_kind_btn_default"] forState:UIControlStateNormal];
            [btn.imageView setContentMode:UIViewContentModeScaleToFill];
            [array addObject:btn];
            btn.imageView.backgroundColor = [UIColor redColor];
            
        }
        _btnArray = array;
    }
    
    return _btnArray;
}

@end
