//
//  GJTDateTool.h
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/17.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 时间处理类
 */
@interface GJTDateTool : NSObject

+ (NSString*)stringFromDate:(NSDate*)date;
+ (NSString*)stringFromDate:(NSDate*)date format:(NSString*)format;
+ (NSString*)stringFromTimeInterval:(NSTimeInterval)timeInterval;
+ (NSString*)stringFromTimeInterval:(NSTimeInterval)timeInterval format:(NSString*)format;
+ (NSDate*)dateFromTimeInterval:(NSTimeInterval)timeInterval;
+ (NSDate*)dateFromString:(NSString*)timeString format:(NSString*)format;
+ (NSTimeInterval)timeIntervalFromDate:(NSDate*)date;
+ (NSTimeInterval)timeIntervalString:(NSString*)dateString format:(NSString*)format;
+ (NSTimeInterval)timeIntervalComponents:(NSDateComponents *)components format:(NSString *)format;
+ (NSDateComponents*)componentsFromDate:(NSDate*)aDate;
+ (NSDateComponents*)componentsFromTimeInterval:(NSTimeInterval)timeInterval;
+ (NSDateComponents*)componentsFromString:(NSString*)dateString format:(NSString*)format;


@end
