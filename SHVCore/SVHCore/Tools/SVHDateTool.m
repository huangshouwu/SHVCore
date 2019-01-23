//
//  SVHDateTool.m
//  Craftsman_rabbit
//
//  Created by huang shervin on 2018/7/17.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHDateTool.h"

@implementation SVHDateTool

+ (NSString*)stringFromDate:(NSDate*)date{
    return [SVHDateTool stringFromDate:date format:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString*)stringFromDate:(NSDate*)date format:(NSString*)format{
    if (!date)
        return @"";
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString* datetimeString = [dateFormatter stringFromDate:date];
    return datetimeString;
}

+ (NSString*)stringFromTimeInterval:(NSTimeInterval)timeInterval{
    return [SVHDateTool stringFromTimeInterval:timeInterval format:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString*)stringFromTimeInterval:(NSTimeInterval)timeInterval format:(NSString*)format{
    return [SVHDateTool stringFromDate:[SVHDateTool dateFromTimeInterval:timeInterval] format:format];
}

+ (NSDate*)dateFromTimeInterval:(NSTimeInterval)timeInterval{
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

+ (NSDate*)dateFromString:(NSString*)timeString format:(NSString*)format{
    if (!timeString.length || !format.length) {
        return nil;
    }
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSDate* aDatetime = [dateFormatter dateFromString:timeString];
    return aDatetime;
}

+ (NSTimeInterval)timeIntervalFromDate:(NSDate*)date{
    return [date timeIntervalSince1970];
}

+ (NSTimeInterval)timeIntervalString:(NSString*)dateString format:(NSString*)format{
    NSDate* date = [SVHDateTool dateFromString:dateString format:format];
    return [SVHDateTool timeIntervalFromDate:date];
}

+ (NSTimeInterval)timeIntervalComponents:(NSDateComponents *)components format:(NSString *)format{
    if (!components) {
        return 0;
    }
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate * date = [calendar dateFromComponents:components];
    return [SVHDateTool timeIntervalFromDate:date];
}

//获取时间日期的年月日，时分秒
+ (NSDateComponents*)componentsFromDate:(NSDate*)aDate{
    if (!aDate){
        return nil;
    }
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond| NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday;
    NSDateComponents *dd = [cal components:unitFlags fromDate:aDate];
    return dd;
}

+ (NSDateComponents*)componentsFromTimeInterval:(NSTimeInterval)timeInterval{
    return [SVHDateTool componentsFromDate:[SVHDateTool dateFromTimeInterval:timeInterval]];
}

+ (NSDateComponents*)componentsFromString:(NSString*)dateString format:(NSString*)format{
    return [SVHDateTool componentsFromDate:[SVHDateTool dateFromString:dateString format:format]];
}

@end
