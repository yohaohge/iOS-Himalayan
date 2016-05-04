//
//  FSUtility.m
//  FangddSalesman
//
//  Created by ysjjchh on 14-4-26.
//  Copyright (c) 2014年 ysjjchh. All rights reserved.
//

#import "FSUtility.h"
#import "UIAlertView+Block.h"
#import <AddressBook/AddressBook.h>
#import <MessageUI/MessageUI.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <CommonCrypto/CommonDigest.h>
#include <net/if.h>
#import "GTMBase64.h"
@implementation FSUtility

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGSize imageSize = CGSizeMake(2, 2);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    
    [color set];
    
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    
    UIImage *colorImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return colorImg;
}

+ (NSString *)formatTime:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:date];
}

+ (NSDate *)dateFromServerString:(NSString *)string {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [formatter dateFromString:string];
}

+ (NSString *)getDateFromTimeString:(NSString *)string {
    
    NSDate *date = [self dateFromServerString:string];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *today = [formatter stringFromDate:[NSDate date]];
    NSString *dstDay = [formatter stringFromDate:date];
    
    if ([today isEqualToString:dstDay]) {
        [formatter setDateFormat:@"今天 HH:mm"];
    } else {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    
    return [formatter stringFromDate:date];
}

+ (BOOL)checkPhoneNumber:(NSString *)phone {
    if (!phone) {
        return NO;
    }
    NSString *trim = [phone stringByTrimmingCharactersInSet:
                      [NSCharacterSet whitespaceCharacterSet]];
    if (trim.length < 11) {
        return NO;
    }
    return YES;
}

+ (void)dial:(NSString *)phoneNumber {
    NSString *dstPhone = [[NSString alloc] initWithFormat:@"tel://%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dstPhone]];
}

+ (void)sms:(NSString *)phoneNumber viewController:(UIViewController *)viewController {
    NSString *dstPhone = [[NSString alloc] initWithFormat:@"sms://%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dstPhone]];
//    if([MFMessageComposeViewController canSendText]) {
//        
//        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
//        controller.recipients = @[phoneNumber];
//        static FSUtility *obj;
//        obj = [[FSUtility alloc] init];
//        controller.messageComposeDelegate = obj;
//        controller.view.backgroundColor = [UIColor whiteColor];
//
//        [IPAYSVProgressHUD showWithStatus:nil maskType:IPAYSVProgressHUDMaskTypeClear];
//        [viewController presentViewController:controller animated:YES completion:^{
//
//        }];
//        [IPAYSVProgressHUD dismiss];
//    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

+ (void)dialWithAlert:(NSString *)phoneNumber {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:phoneNumber
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"呼叫", nil];
    [alert showWithCompleteHandler:^(NSInteger index) {
        if (1 == index) {
            [FSUtility dial:phoneNumber];
        }
    }];
}

+ (int)systemVersion {
    return [[[UIDevice currentDevice] systemVersion] intValue];
}

+ (BOOL)isIphone5 {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    if (screenHeight > 567) {
        
        return YES;
    }
    else
    {
        return NO;
    }
    return NO;
}

+ (BOOL)authorizationAddressBook {
    BOOL flag = NO;
    
    NSLog(@"%@",[[UIDevice currentDevice] systemVersion]);
    NSArray *ary = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
    if ([ary[0] intValue] < 6) {
        return YES;
    }
    
    ABAuthorizationStatus addr = ABAddressBookGetAuthorizationStatus();
    switch (addr) {
        case kABAuthorizationStatusNotDetermined:
        {
            //[[UIDevice currentDevice] systemVersion]
            flag = NO;
            break;
        }
        case kABAuthorizationStatusRestricted:
        {
            flag = NO;
            break;
        }
        case kABAuthorizationStatusDenied:
        {
            flag = NO;
            break;
        }
        case kABAuthorizationStatusAuthorized:
        {
            flag = YES;
            break;
        }
        default:
            break;
    }
    if (!flag) {
        ABAddressBookRef addressBook = nil;
        
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 6.0)
        {
            addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
            //等待同意后向下执行
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
                dispatch_semaphore_signal(sema);
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        
        if (addressBook) {
            flag = YES;
            CFRelease(addressBook);
        }
    }
    
    return flag;
}

+ (NSString *)decimalNumber:(NSNumber *)number {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
//    NSString *temp = [formatter stringFromNumber:number];
//    if (![temp hasSubString:@"."]) {
//        return temp;
//    }
    [formatter setPositiveFormat:@"###,##0.00;"];
    return [formatter stringFromNumber:number];
}

+ (void)openUrl:(NSString *)urlString {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

+ (int64_t)getTimeBySeconds {
    return [[NSDate date] timeIntervalSince1970];
}

+ (NSString *)getIPAddress
{
    NSString *address = nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                //NSLog(@"%@", [NSString stringWithUTF8String:temp_addr->ifa_name]);
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];

                }
                
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"pdp_ip0"]) {
                    // Get NSString from C String
                    if (!address) {
                        address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    }
                
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return (address?address:@"");
}

+ (NSString *)nonNilString:(NSString *)string {
    return string? string : @"";
}

+ (BOOL)isListAvailable:(NSArray *)one {
    if (one && one.count > 0) {
        return YES;
    }
    
    return NO;
}

+ (NSString *)formatTimeByLong:(int64_t)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    return [formatter stringFromDate:date];
}


#pragma mark 图片处理
+(UIImage*)compressImage:(UIImage*)source width:(float)width height:(float)height {
    CGFloat scaledWidth = source.size.width>=width?width:source.size.width;
    CGFloat scaledHeight = source.size.height>=height?height:source.size.height;
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    UIGraphicsBeginImageContext(thumbnailRect.size); // this will crop
    
    [source drawInRect:thumbnailRect];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIFont *)dataFont
{
    if ([[UIDevice currentDevice].systemVersion intValue] > 8)
    {
        return [UIFont fontWithName:@".SFUIText-Regular" size:14];
    }
    else
    {
        return [UIFont systemFontOfSize:14];
    }
}
+ (NSString *) sha1Str:(NSData *)input
{
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(input.bytes, (CC_LONG)input.length, digest);
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    base64 = [GTMBase64 webSafeEncodeData:base64 padded:YES];
    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    NSString *sha1Key = [output substringToIndex:27];
    return [NSString stringWithFormat:@"code=%d%csha1=%@%cdata=",1,0x1F,sha1Key,0x1F];
}
@end












