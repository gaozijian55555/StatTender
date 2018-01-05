//
//  NSDate+TCTool.h
//  TC_Eagle
//
//  Created by jinming on 3/10/16.
//  Copyright © 2016 Bestpay. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const DATEFORMAT_YMDHMS1;// @"yyyyMMddHHmmss"
extern NSString *const DATEFORMAT_YMDHMS2;// @"yyyy-MM-dd HH:mm:ss"

extern NSString *const DATEFORMAT_YMD1;// @"yyyyMMdd"
extern NSString *const DATEFORMAT_YMD2;// @"yyyy-MM-dd"
extern NSString *const DATEFORMAT_YMD3;// @"yyyy年MM月dd日"
extern NSString *const DATEFORMAT_YMD4;// @"yyyyMM01"

extern NSString *const DATEFORMAT_HMS1;// @"HHmmss"
extern NSString *const DATEFORMAT_HMS2;// @"HH:mm:ss"

@interface NSDate (TCTool)

/**
 *  NSDate对象转化为NSString对象
 *
 *  @param format 日期格式
 *
 *  @return 日期字符串
 */
- (NSString *)dateStringWithFormat:(NSString *)format;

/**
 *  [NSDate date] 转化为NSString
 *
 *  @param format 日期格式
 *
 *  @return 日期字符串
 */
+ (NSString *)currentDateStringWithFormat:(NSString *)format;

#pragma mark - Quick Date

- (NSDate *)firstDayOfWeek;
- (NSDate *)firstDayOfMonth;
- (NSDate *)firstDayOfYear;

- (NSDate *)dateByAddingDay:(NSInteger)day;
- (NSDate *)lastDay;
- (NSDate *)nextDay;

- (NSDate *)dateByAddingWeek:(NSInteger)week;
- (NSDate *)lastWeek;
- (NSDate *)nextWeek;

- (NSDate *)dateByAddingMonth:(NSInteger)month;
- (NSDate *)lastMonth;
- (NSDate *)nextMonth;

- (NSDate *)dateByAddingYear:(NSInteger)year;
- (NSDate *)lastYear;
- (NSDate *)nextYear;

#pragma mark - Component

- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;

- (NSInteger)weekday;
- (NSInteger)weekOfMonth;
- (NSInteger)weekOfYear;

- (NSInteger)weekdayOrdinal;
- (BOOL)leapMonth;
- (NSInteger)nanosecond;

- (NSDateComponents *)dateComponents;

@end
