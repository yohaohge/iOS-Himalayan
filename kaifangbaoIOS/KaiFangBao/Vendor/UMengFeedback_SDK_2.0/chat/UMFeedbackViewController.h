//
//  UMFeedbackViewController.h
//  UMeng Analysis
//
//  Created by liu yu on 7/12/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMFeedback.h"

@interface UMFeedbackViewController2 : UIViewController <UMFeedbackDataDelegate> {
    
    BOOL _shouldScrollToBottom;
}

@property(nonatomic, retain) IBOutlet UITableView *mTableView;
@property(nonatomic, retain) IBOutlet UIToolbar *mToolBar;
@property(nonatomic, retain) UMFeedback *feedbackClient;
@property(nonatomic, retain) UITextField *mTextField;
@property(nonatomic, retain) UIBarButtonItem *mSendItem;
@property(nonatomic, retain) NSArray *mFeedbackData;
@property(nonatomic, copy) NSString *appkey;
@property(nonatomic, retain) CALayer *gradientLayer;
@end
