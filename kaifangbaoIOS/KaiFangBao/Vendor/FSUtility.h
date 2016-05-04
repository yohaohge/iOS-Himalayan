//
//  FSUtility.h
//  FangddSalesman
//
//  Created by ysjjchh on 14-4-26.
//  Copyright (c) 2014年 ysjjchh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FSUtility : NSObject

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (NSString *)formatTime:(NSDate *)date format:(NSString *)format;
+ (NSDate *)dateFromServerString:(NSString *)string;

+ (NSString *)getDateFromTimeString:(NSString *)string;

+ (BOOL)checkPhoneNumber:(NSString *)phone;

+ (void)dial:(NSString *)phoneNumber;

+ (void)dialWithAlert:(NSString *)phoneNumber;

+ (void)sms:(NSString *)phoneNumber viewController:(UIViewController *)viewController;

+ (int)systemVersion;

+ (BOOL)isIphone5;

+ (BOOL)authorizationAddressBook;

+ (NSString *)decimalNumber:(NSNumber *)number;

+ (void)openUrl:(NSString *)urlString;

+ (int64_t)getTimeBySeconds;

+ (NSString *)getIPAddress;

+ (NSString *)nonNilString:(NSString *)string;

+ (BOOL)isListAvailable:(NSArray *)one;

+ (NSString *)formatTimeByLong:(int64_t)time;
+ (NSString *) sha1Str:(NSData *)input;
#pragma mark 图片处理
/**将图片压缩到指定分辨率，如果图片本身小于该分辨率，则不予压缩 **/
+(UIImage*)compressImage:(UIImage*)source width:(float)width height:(float)height;

+ (UIFont *)dataFont;
@end







