//
//  NSDate+Addition.h
//  TC_Eagle
//
//  Created by gao on 15/9/18.
//  Copyright (c) 2016年 Eagle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const DateFormat_YMDHMS;
UIKIT_EXTERN NSString *const DateFormat_YMD;
UIKIT_EXTERN NSString *const DateFormat_YMD_Chinese;
UIKIT_EXTERN NSString *const DateFormat_HMS;
UIKIT_EXTERN NSString *const DateFormat_H_M_S;
UIKIT_EXTERN NSString *const DateFormat_YMD_HMS;
UIKIT_EXTERN NSString *const DateFormat_Y_M_D;
UIKIT_EXTERN NSString *const DateFormat_Y_M_ONE;
UIKIT_EXTERN NSString *const DateFormat_YMD_H_M_S;

@interface NSDate (Addition)

//NSString转换成NSDate
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)formate;
+ (NSString *)curDateString:(NSString *)format;
+ (NSTimeInterval)curDateTimeInterval;

//NSDate转换成NSString
- (NSString *)getDateString:(NSString *)format;

#pragma mark - 这个月的第一天 这一周的第一天 这一年的第一天

- (NSDate *)theFirstDayOfWeek;
- (NSDate *)theFirstDayOfMonth;
- (NSDate *)theFirstDayOfYear;

#pragma mark -

- (NSDate *)dateByAppendingDay:(NSInteger)day;
- (NSDate *)lastDay;
- (NSDate *)nextDay;

- (NSDate *)dateByAppendingWeek:(NSInteger)week;
- (NSDate *)lastWeek;
- (NSDate *)nextWeek;

- (NSDate *)dateByAppendingMonth:(NSInteger)month;
- (NSDate *)lastMonth;
- (NSDate *)nextMonth;

- (NSDate *)dateByAppendingYear:(NSInteger)year;
- (NSDate *)lastYear;
- (NSDate *)nextYear;

#pragma mark - 各种属性

- (NSDateComponents *)dateComponents;

- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
- (NSInteger)day;
- (NSInteger)month;
- (NSInteger)year;

- (NSInteger)week;
- (NSInteger)weekday;
- (NSInteger)weekOfMonth;
- (NSInteger)weekOfYear;

@end
