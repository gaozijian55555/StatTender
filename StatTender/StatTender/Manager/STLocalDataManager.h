//
//  STLocalDataManager.h
//  StatTender
//
//  Created by 高子健 on 17/4/15.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, STOrderStateOptions) {
    
    STOrderStateOptionsPrinted     = 1 << 1,           // 已打印/未打印
    STOrderStateOptionsSigned      = 1 << 3,           // 已签单/未签单
    STOrderStateOptionsCleared     = 1 << 5,           // 已结算/未结算
    
};

@interface STLocalDataManager : NSObject

+ (instancetype)manager;

/**
 Save Order

 @param order orderObject
 @return synchronize result
 */
- (BOOL)saveLocalDataWithOrder:(STOrderObject *)order;

    
/**
 Fetch Orders
 
 @return array<orders>
 */
- (NSArray<STOrderObject *> *)fetchAllOrders;
- (NSArray<STOrderObject *> *)fetchOrdersWithCompany:(NSString *)company;
- (NSArray<STOrderObject *> *)fetchOrdersFrom:(NSDate *)fromDate to:(NSDate *)toDate; //DATEFORMAT_YMDHMS2
- (NSArray<STOrderObject *> *)fetchOrdersWithCompany:(NSString *)company from:(NSDate *)fromDate to:(NSDate *)toDate; //DATEFORMAT_YMDHMS2

- (NSArray<STOrderObject *> *)fetchOrdersWithOptions:(STOrderStateOptions)options;

@end


CG_INLINE BOOL SaveLocalOrder(STOrderObject *order) {
    return [[STLocalDataManager manager] saveLocalDataWithOrder:order];
};
