//
//  NSDate+TCTool.m
//  TC_Eagle
//
//  Created by jinming on 3/10/16.
//  Copyright © 2016 Bestpay. All rights reserved.
//

#import "NSDate+TCTool.h"

NSString *const DATEFORMAT_YMDHMS1 = @"yyyyMMddHHmmss";
NSString *const DATEFORMAT_YMDHMS2 = @"yyyy-MM-dd HH:mm";

NSString *const DATEFORMAT_YMD1 = @"yyyyMMdd";
NSString *const DATEFORMAT_YMD2 = @"yyyy-MM-dd";
NSString *const DATEFORMAT_YMD3 = @"yyyy年MM月dd日";
NSString *const DATEFORMAT_YMD4 = @"yyyyMM01";

NSString *const DATEFORMAT_HMS1 = @"HHmmss";
NSString *const DATEFORMAT_HMS2 = @"HH:mm:ss";

@implementation NSDate (TCTool)

- (NSString *)dateStringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:self];
}

+ (NSString *)currentDateStringWithFormat:(NSString *)format
{
    return [[NSDate date] dateStringWithFormat:format];
}

#pragma mark - Quick Date

- (NSDate *)firstDayOfWeek
{
    NSDateComponents *dateComp = [self dateComponents];
    dateComp.day = dateComp.day - (dateComp.weekday - 1);
    
    return [dateComp date];
}
- (NSDate *)firstDayOfMonth
{
    NSDateComponents *dateComp = [self dateComponents];
    dateComp.day = 1;
    
    return [dateComp date];
}
- (NSDate *)firstDayOfYear
{
    NSDateComponents *dateComp = [self dateComponents];
    dateComp.day = 1;
    dateComp.month = 1;
    
    return [dateComp date];
}


- (NSDate *)dateByAddingDay:(NSInteger)day
{
    NSDateComponents *dateComp = [self dateComponents];
    dateComp.day = dateComp.day + day;
    
    return [dateComp date];
}
- (NSDate *)lastDay
{
    return [self dateByAddingDay:-1];
}
- (NSDate *)nextDay
{
    return [self dateByAddingDay:+1];
}


- (NSDate *)dateByAddingWeek:(NSInteger)week
{
    return [self dateByAddingDay:week*7];
}
- (NSDate *)lastWeek
{
    return [self dateByAddingWeek:-1];
}
- (NSDate *)nextWeek
{
    return [self dateByAddingWeek:+1];
}


- (NSDate *)dateByAddingMonth:(NSInteger)month
{
    NSDateComponents *dateComp = [self dateComponents];
    dateComp.month = dateComp.month + month;
    
    return [dateComp date];
}
- (NSDate *)lastMonth
{
    return [self dateByAddingMonth:-1];
}
- (NSDate *)nextMonth
{
    return [self dateByAddingMonth:+1];
}


- (NSDate *)dateByAddingYear:(NSInteger)year
{
    NSDateComponents *dateComp = [self dateComponents];
    dateComp.year = dateComp.year + year;
    
    return [dateComp date];
}
- (NSDate *)lastYear
{
    return [self dateByAddingYear:-1];
}
- (NSDate *)nextYear
{
    return [self dateByAddingYear:+1];
}

#pragma mark - Component

- (NSInteger)year
{
    return [[self dateComponents] year];
}

- (NSInteger)month
{
    return [[self dateComponents] month];
}

- (NSInteger)day
{
    return [[self dateComponents] day];
}

- (NSInteger)hour
{
    return [[self dateComponents] hour];
}

- (NSInteger)minute
{
    return [[self dateComponents] minute];
}

- (NSInteger)second
{
    return [[self dateComponents] second];
}

- (NSInteger)weekday
{
    return [[self dateComponents] weekday];
}

- (NSInteger)weekOfMonth
{
    return [[self dateComponents] weekOfMonth];
}

- (NSInteger)weekOfYear
{
    return [[self dateComponents] weekOfYear];
}

- (NSInteger)weekdayOrdinal
{
    return [[self dateComponents] weekdayOrdinal];
}

- (BOOL)leapMonth
{
    return [[self dateComponents] isLeapMonth];
}

- (NSInteger)nanosecond
{
    return [[self dateComponents] nanosecond];
}

- (NSDateComponents *)dateComponents
{
    NSUInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
    | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
    | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear
    | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitQuarter | NSCalendarUnitNanosecond
    | NSCalendarUnitCalendar | NSCalendarUnitTimeZone;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    return [calendar components:units fromDate:self];
}

@end
