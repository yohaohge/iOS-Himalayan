//
//  ItemCell.h
//  Himalayan
//
//  Created by fdd_zhangou on 16/3/11.
//  Copyright © 2016年 fdd_zhangou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (nonatomic, strong) NSString *leftTitle;
@property (nonatomic, strong) NSString *rightTitle;
@property (nonatomic, strong) UIImage *leftImage;
@property (nonatomic, strong) UIImage *rightImage;

@end
