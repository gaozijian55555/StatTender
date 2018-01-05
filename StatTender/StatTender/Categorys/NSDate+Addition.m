//
//  NSDate+Addition.m
//  TC_Eagle
//
//  Created by gao on 15/9/18.
//  Copyright (c) 2016年 Eagle. All rights reserved.
//

#import "NSDate+Addition.h"

NSString *const DateFormat_YMDHMS = @"yyyyMMddHHmmss";
NSString *const DateFormat_YMD = @"yyyyMMdd";
NSString *const DateFormat_YMD_Chinese = @"yyyy年MM月dd日";
NSString *const DateFormat_HMS = @"HHmmss";
NSString *const DateFormat_H_M_S = @"HH:mm:ss";
NSString *const DateFormat_YMD_HMS = @"yyyy-MM-dd HH:mm:ss";
NSString *const DateFormat_Y_M_D = @"yyyy-MM-dd";
NSString *const DateFormat_Y_M_ONE = @"yyyyMM01";
NSString *const DateFormat_YMD_H_M_S = @"yyyyMMddHH:mm:ss";

@implementation NSDate (Addition)

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)formate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:formate];
    return [dateFormatter dateFromString:dateString];
}

+ (NSTimeInterval)curDateTimeInterval{
    return [[NSDate date] timeIntervalSince1970];
}

+ (NSString *)curDateString:(NSString *)format{
    return [[NSDate date] getDateString:format];
}

- (NSString *)getDateString:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

#pragma mark - 这个月的第一天 这一周的第一天 这一年的第一天

- (NSDate *)theFirstDayOfWeek{
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components = [cal components:unitFlags fromDate:self];
    
    components.day = components.day-components.weekday+1;
    
    return [cal dateFromComponents:components];
}
- (NSDate *)theFirstDayOfMonth{
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components = [cal components:unitFlags fromDate:self];
    components.day = 1;
    
    return [cal dateFromComponents:components];
}
- (NSDate *)theFirstDayOfYear{
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components = [cal components:unitFlags fromDate:self];
    components.day = 1;
    components.month = 1;
    
    return [cal dateFromComponents:components];
}

#pragma mark -

- (NSDate *)dateByAppendingDay:(NSInteger)day{
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components = [cal components:unitFlags fromDate:self];
    components.day = components.day+day;
    
    return [cal dateFromComponents:components];
}
- (NSDate *)lastDay{
    return [self dateByAppendingDay:-1];
}
- (NSDate *)nextDay{
    return [self dateByAppendingDay:1];
}

- (NSDate *)dateByAppendingWeek:(NSInteger)week{
    return [self dateByAppendingDay:week*7];
}
- (NSDate *)lastWeek{
    return [self dateByAppendingWeek:-1];
}
- (NSDate *)nextWeek{
    return [self dateByAppendingWeek:1];
}

- (NSDate *)dateByAppendingMonth:(NSInteger)month{
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components = [cal components:unitFlags fromDate:self];
    
    components.month = components.month+month;
    
    return [cal dateFromComponents:components];
}
- (NSDate *)lastMonth{
    return [self dateByAppendingMonth:-1];
}
- (NSDate *)nextMonth{
    return [self dateByAppendingMonth:1];
}

- (NSDate *)dateByAppendingYear:(NSInteger)year{
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components = [cal components:unitFlags fromDate:self];
    components.year = components.year+year;
    
    return [cal dateFromComponents:components];
}
- (NSDate *)lastYear{
    return [self dateByAppendingYear:-1];
}
- (NSDate *)nextYear{
    return [self dateByAppendingYear:1];
}

#pragma mark - 各种属性

- (NSDateComponents *)dateComponents{
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear;
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components = [cal components:unitFlags fromDate:self];
    
    return components;
}

- (NSInteger)hour{
    return [self dateComponents].hour;
}
- (NSInteger)minute{
    return [self dateComponents].minute;
}
- (NSInteger)second{
    return [self dateComponents].second;
}
- (NSInteger)day{
    return [self dateComponents].day;
}
- (NSInteger)month{
    return [self dateComponents].month;
}
- (NSInteger)year{
    return [self dateComponents].year;
}

- (NSInteger)week{
    return [self dateComponents].weekdayOrdinal;
}
- (NSInteger)weekday{
    return [self dateComponents].weekday;
}
- (NSInteger)weekOfMonth{
    return [self dateComponents].weekOfMonth;
}
- (NSInteger)weekOfYear{
    return [self dateComponents].weekOfYear;
}

@end
