//
//  FeedbackTableViewCell.m
//  UMeng Analysis
//
//  Created by liuyu on 9/18/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import "UMFeedbackTableViewCellLeft.h"

@interface UMFeedbackTableViewCellLeft ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *messageBackgroundView;
@property (nonatomic, retain) UIImageView *iconImage;

@end

@implementation UMFeedbackTableViewCellLeft

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(24, 10, 35, 35)];
        _iconImage.clipsToBounds=YES;
        _iconImage.layer.cornerRadius=17.5;
        _iconImage.contentMode = UIViewContentModeScaleAspectFill;
        _iconImage.image = [UIImage imageNamed:@"icon_manager"];
        [self.contentView addSubview:_iconImage];
        
        _messageBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(69, 10, 226, 55)];
        UIImage *img=[UIImage imageNamed:@"left_bg"];
        img=[img stretchableImageWithLeftCapWidth:15 topCapHeight:15];
        _messageBackgroundView.image = img;
        [self.contentView addSubview:_messageBackgroundView];
        
        _timestampLabel = [[UILabel alloc] init];
        _timestampLabel.backgroundColor = [UIColor clearColor];
        _timestampLabel.font = [UIFont systemFontOfSize:10.0f];
        _timestampLabel.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0];
        _timestampLabel.frame = CGRectMake(15.0f, 6, 100, 14);
        _timestampLabel.textAlignment=NSTextAlignmentLeft;
        [_messageBackgroundView addSubview:_timestampLabel];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 23, 201, .5)];
        _lineView.backgroundColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1];
        [_messageBackgroundView addSubview:_lineView];
        
        self.contentText = [[UILabel alloc] initWithFrame:CGRectMake(15, 29, 201, 15)];
        self.contentText.font = [UIFont systemFontOfSize:15.0f];
        self.contentText.lineBreakMode = NSLineBreakByWordWrapping;
        self.contentText.numberOfLines = 0;
        self.contentText.textAlignment = NSTextAlignmentLeft;
        self.contentText.textColor = [UIColor blackColor];
        if ([[UIDevice currentDevice].systemVersion doubleValue] < 7.0f)
        {
            self.contentText.backgroundColor = [UIColor clearColor];
        }
        [_messageBackgroundView addSubview:_contentText];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect contentTextFrame = self.contentText.frame;
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize labelSize = [self.contentText.text boundingRectWithSize:CGSizeMake(201, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName:style} context:nil].size;
    contentTextFrame.size = labelSize;
    self.contentText.frame = contentTextFrame;
    NSInteger width = labelSize.width > _timestampLabel.frame.size.width ? labelSize.width : _timestampLabel.frame.size.width;
    _lineView.frame = CGRectMake(_lineView.frame.origin.x, _lineView.frame.origin.y, width, _lineView.frame.size.height);
    
    _messageBackgroundView.frame = CGRectMake(_messageBackgroundView.frame.origin.x, _messageBackgroundView.frame.origin.y, width + 25, labelSize.height + 37 > 55 ? labelSize.height + 37 : 55);
    
}

@end
