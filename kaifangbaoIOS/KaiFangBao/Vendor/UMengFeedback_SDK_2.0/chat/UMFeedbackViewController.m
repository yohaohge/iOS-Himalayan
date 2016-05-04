//
//  UMFeedbackViewController.m
//  UMeng Analysis
//
//  Created by liu yu on 7/12/12.
//  Copyright (c) 2012 Realcent. All rights reserved.
//

#import "UMFeedbackViewController.h"
#import "UMFeedbackTableViewCellLeft.h"
#import "UMFeedbackTableViewCellRight.h"
#import "SVPullToRefresh.h"
#import "FSUtility.h"
#import "FrameAccessor.h"

#define TOP_MARGIN 20.0f
#define kNavigationBar_ToolBarBackGroundColor  [UIColor colorWithRed:0.149020 green:0.149020 blue:0.149020 alpha:1.0]
#define kContactViewBackgroundColor  [UIColor colorWithRed:0.078 green:0.584 blue:0.97 alpha:1.0]

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

static UITapGestureRecognizer *tapRecognizer;

@implementation UINavigationBar (CustomImage)
//- (void)drawRect:(CGRect)rect {
//    UIImage *image = [UIImage imageNamed:@"nav_btn_bg"];
//    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//}
@end

@interface UMFeedbackViewController2 ()
@property(nonatomic, copy) NSString *mContactInfo;
@end

@implementation UMFeedbackViewController2

@synthesize mTextField = _mTextField, mTableView = _mTableView, mToolBar = _mToolBar, mFeedbackData = _mFeedbackData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setHidesBottomBarWhenPushed:YES];
    }
    return self;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (void)setupTableView {
    self.mTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    __weak UMFeedbackViewController2 *wself = self;
    [self.mTableView addPullToRefreshWithActionHandler:^{
        [wself.feedbackClient get];
    }];
}

- (void)setupToolbar {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    button.frame = CGRectMake(250, 7, 63.0f, 30.0f);
    button.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [button setTitle: @"发送" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x526cfd) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendFeedback:) forControlEvents:UIControlEventTouchUpInside];

    [self.mToolBar addSubview:button];

    [self setupTextField];
}

- (void)setupTextField {
    _mTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 7, 232, 30.0f)];
    _mTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _mTextField.backgroundColor = [UIColor whiteColor];
    _mTextField.textAlignment = NSTextAlignmentLeft;
    _mTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _mTextField.layer.borderWidth = 1;
    _mTextField.layer.borderColor = [UIColor colorWithWhite:.85 alpha:1].CGColor;
    _mTextField.font = [UIFont systemFontOfSize:14.0f];
    _mTextField.layer.cornerRadius=4;
    _mTextField.clipsToBounds=YES;
    _mTextField.contentMode = UIViewContentModeScaleAspectFill;
    _mTextField.placeholder = @"输入文字内容";
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 30)];
    _mTextField.leftView = paddingView;
    _mTextField.leftViewMode = UITextFieldViewModeAlways;
    //_mTextField.delegate = (id <UITextFieldDelegate>) self;

    [self.mToolBar addSubview:_mTextField];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加头部渐变
    self.gradientLayer.frame = CGRectMake(0, -64,self.gradientLayer.frame.size.width,self.gradientLayer.frame.size.height);
    [self.view.layer insertSublayer:self.gradientLayer atIndex:0];
    self.navigationItem.title = @"意见反馈";
    
    if ([FSUtility systemVersion] < 7) {
        self.view.height -= 44;
    } else {
        self.view.height -= 64;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self setBackItem];
    [self setBackgroundColor];
    [self setupTableView];
    [self setupToolbar];
    [self setFeedbackClient];
    [self updateTableView:nil];
    [self handleKeyboard];
    [_feedbackClient get];

    _shouldScrollToBottom = YES;
}

- (void)setBackItem
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 34)];
    [button setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
    button.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(onBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)onBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 开启
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)handleKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
}

- (void)setFeedbackClient {
    _mFeedbackData = [[NSArray alloc] init];
    _feedbackClient = [UMFeedback sharedInstance];
    if ([self.appkey isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NO Umeng kUmengAppkey"
                                                        message:@"Please define UMENG_APPKEY macro!"
                                                       delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    [_feedbackClient setAppkey:self.appkey delegate:(id <UMFeedbackDataDelegate>) self];

//    从缓存取topicAndReplies
    self.mFeedbackData = _feedbackClient.topicAndReplies;
}

- (void)setBackgroundColor {
    self.mTableView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    if ([self.mToolBar respondsToSelector:@selector(setBackgroundImage:forToolbarPosition:barMetrics:)]) {
        UIImage *image = [FSUtility imageWithColor:[UIColor whiteColor]];
        [self.mToolBar setBackgroundImage:image forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    } else {
        self.mToolBar.barStyle = UIBarStyleBlack;
    }
}

- (void)didTapAnywhere:(UITapGestureRecognizer *)recognizer {
    [self.mTextField resignFirstResponder];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark keyboard notification

- (void)keyboardWillShow:(NSNotification *)notification {
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat keyboardHeight = [[[notification userInfo] objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;

    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                         CGRect toolbarFrame = self.mToolBar.frame;
                         toolbarFrame.origin.y = self.view.bounds.size.height - keyboardHeight - toolbarFrame.size.height;
                         self.mToolBar.frame = toolbarFrame;

                         CGRect tableViewFrame = self.mTableView.frame;
                         tableViewFrame.size.height = self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height - keyboardHeight;
                         
                         self.mTableView.frame = tableViewFrame;
                     }
                     completion:^(BOOL finished) {
                         if (_shouldScrollToBottom) {
                             [self scrollToBottom];
                         }
                     }
    ];

    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    float animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView beginAnimations:@"bottomBarDown" context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    CGRect toolbarFrame = self.mToolBar.frame;
    toolbarFrame.origin.y = self.view.bounds.size.height - toolbarFrame.size.height;
    self.mToolBar.frame = toolbarFrame;
    
    CGRect tableViewFrame = self.mTableView.frame;
    tableViewFrame.size.height = self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height;
    self.mTableView.frame = tableViewFrame;
    
    [UIView commitAnimations];
    
    [self.view removeGestureRecognizer:tapRecognizer];
}

- (void)backToPrevious {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

- (void)sendFeedback:(id)sender {
    if ([self.mTextField.text length]) {
        
        
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        [dictionary setObject:[self.mTextField.text copy] forKey:@"content"];

//        TUserProfile *user = [FSMemory sharedMemory].userProfile;
//        if (user)
//        {
//            NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"用户名称":user.userName, @"用户ID":@(user.userId)}];
//            if ([FSMemory sharedMemory].projectInfo) {
//                [dic setValue:[FSMemory sharedMemory].projectInfo.projectName forKey:@"楼盘名称"];
//            }
//            [_feedbackClient updateUserInfo:@{@"contact":dic}];
//        }
        
        [_feedbackClient post:dictionary];
        [self.mTextField resignFirstResponder];
        _shouldScrollToBottom = YES;
    }
}

#pragma mark tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_mFeedbackData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *content = [[_feedbackClient.topicAndReplies objectAtIndex:(NSUInteger) indexPath.row] objectForKey:@"content"];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize labelSize = [content boundingRectWithSize:CGSizeMake(201, MAXFLOAT)
                                                           options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName:style} context:nil].size;
    CGFloat height = labelSize.height + 37 + TOP_MARGIN;
    return height > 75 ? height : 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *L_CellIdentifier = @"L_UMFBTableViewCell";
    static NSString *R_CellIdentifier = @"R_UMFBTableViewCell";

    NSDictionary *data = [self.mFeedbackData objectAtIndex:(NSUInteger) indexPath.row];

    if ([[data valueForKey:@"type"] isEqualToString:@"dev_reply"]) {
        UMFeedbackTableViewCellLeft *cell = (UMFeedbackTableViewCellLeft *) [tableView dequeueReusableCellWithIdentifier:L_CellIdentifier];
        if (cell == nil) {
            cell = [[UMFeedbackTableViewCellLeft alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:L_CellIdentifier];
        }

        cell.contentText.text = [data valueForKey:@"content"];
        NSNumber *time = [data valueForKey:@"created_at"];
        cell.timestampLabel.text = [FSUtility formatTimeByLong:[time longLongValue]/1000];
        cell.contentView.backgroundColor = UIColorFromRGB(0xF7F7F7);
        return cell;
    }
    else
    {

        UMFeedbackTableViewCellRight *cell = (UMFeedbackTableViewCellRight *) [tableView dequeueReusableCellWithIdentifier:R_CellIdentifier];
        if (cell == nil) {
            cell = [[UMFeedbackTableViewCellRight alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:R_CellIdentifier];
        }
        cell.contentView.backgroundColor=UIColorFromRGB(0xF7F7F7);
        cell.contentText.text = [data valueForKey:@"content"];
        NSNumber *time = [data valueForKey:@"created_at"];
        cell.timestampLabel.text = [FSUtility formatTimeByLong:[time longLongValue]/1000];
        return cell;

    }
}

#pragma mark Umeng Feedback delegate

- (void)updateTableView:(NSError *)error {
    if ([self.mFeedbackData count]) {
        [self.mTableView reloadData];
        [self.mTableView setContentOffset:CGPointMake(0, self.mTableView.contentSize.height>self.mTableView.frame.size.height?self.mTableView.contentSize.height-self.mTableView.frame.size.height:0) animated:YES];
        
    }
}

- (void)updateTextField:(NSError *)error {
    if (!error) {
        self.mTextField.text = @"";
        [_feedbackClient get];
    }
}

- (void)getFinishedWithError:(NSError *)error {
    [self.mTableView.pullToRefreshView stopAnimating];
    if (!error) {
        [self updateTableView:error];
    }

    if (_shouldScrollToBottom) {
        [self scrollToBottom];
    }
}

- (void)postFinishedWithError:(NSError *)error {

    if (!error)
    {
//        [self.hud showSuccessWithString:@"感谢您的反馈!"];
    }
    else
    {
//        [self.hud showSuccessWithString:@"发送失败!"];
    
    }

    [self updateTextField:error];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollToBottom {
    if ([self.mTableView numberOfRowsInSection:0] > 1) {
        NSInteger lastRowNumber = [self.mTableView numberOfRowsInSection:0] - 1;
        NSIndexPath *ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:0];
        [self.mTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}


#pragma mark UITextField Delegate Methods

//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//
//    return YES;
//}


- (void)dealloc {
    _feedbackClient.delegate = nil;

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
