//
//  STLocalDataManager.m
//  StatTender
//
//  Created by 高子健 on 17/4/15.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STLocalDataManager.h"

static STLocalDataManager *manager = nil;

@implementation STLocalDataManager

+ (instancetype)manager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (BOOL)saveLocalDataWithOrder:(STOrderObject *)order
{
    NSDictionary *dict_order = [order mj_keyValues];
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    
    if (order.objectID && order.objectID.length) {
        [df setObject:dict_order forKey:order.objectID];
    } else {
        [df setObject:dict_order forKey:order.downAt];
    }
    return [df synchronize];
}

- (NSArray<STOrderObject *> *)fetchAllOrders
{
    NSDictionary *defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    NSMutableArray *array_result = [NSMutableArray array];
    for (NSString *keys in defaults) {
        NSDictionary *dict_temp = (NSDictionary *)defaults[keys];
        if ([dict_temp isKindOfClass:[NSDictionary class]] && dict_temp != nil)
            [array_result addObject:[STOrderObject mj_objectWithKeyValues:dict_temp]];
    }
    return array_result;
}

- (NSArray<STOrderObject *> *)fetchOrdersWithCompany:(NSString *)company
{
    NSDictionary *defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    NSMutableArray *array_result = [NSMutableArray array];
    for (NSString *keys in defaults) {
        NSDictionary *dict_temp = (NSDictionary *)defaults[keys];
        if ([dict_temp isKindOfClass:[NSDictionary class]] && dict_temp != nil)
            if ([dict_temp[@"companyName"] isEqualToString:company])
                [array_result addObject:[STOrderObject mj_objectWithKeyValues:dict_temp]];
    }
    return array_result;
}

- (NSArray<STOrderObject *> *)fetchOrdersFrom:(NSDate *)fromDate to:(NSDate *)toDate
{
    NSDictionary *defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    NSMutableArray *array_result = [NSMutableArray array];
    for (NSString *keys in defaults) {
        NSDictionary *dict_temp = (NSDictionary *)defaults[keys];
        if ([dict_temp isKindOfClass:[NSDictionary class]] && dict_temp != nil) {
            NSDate *date_dict_temp = [NSDate dateFromString:dict_temp[@"downAt"] format:DATEFORMAT_YMDHMS2];
            NSComparisonResult result_from = [fromDate compare:date_dict_temp];
            NSComparisonResult result_to = [toDate compare:date_dict_temp];
            if (result_from == NSOrderedAscending && result_to == NSOrderedDescending)
                [array_result addObject:[STOrderObject mj_objectWithKeyValues:dict_temp]];
        }
    }
    return array_result;
}

- (NSArray<STOrderObject *> *)fetchOrdersWithCompany:(NSString *)company from:(NSDate *)fromDate to:(NSDate *)toDate
{
    NSDictionary *defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    NSMutableArray *array_result = [NSMutableArray array];
    for (NSString *keys in defaults) {
        NSDictionary *dict_temp = (NSDictionary *)defaults[keys];
        if ([dict_temp isKindOfClass:[NSDictionary class]] && dict_temp != nil) {
            if ([dict_temp[@"companyName"] isEqualToString:company]) {
                NSDate *date_dict_temp = [NSDate dateFromString:dict_temp[@"downAt"] format:DATEFORMAT_YMDHMS2];
                NSComparisonResult result_from = [fromDate compare:date_dict_temp];
                NSComparisonResult result_to = [toDate compare:date_dict_temp];
                if (result_from == NSOrderedAscending && result_to == NSOrderedDescending)
                    [array_result addObject:[STOrderObject mj_objectWithKeyValues:dict_temp]];
            }
        }
    }
    return array_result;
}

- (NSArray<STOrderObject *> *)fetchOrdersWithOptions:(STOrderStateOptions)options
{
    NSDictionary *defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    NSMutableArray *array_result = [NSMutableArray array];
    for (NSString *keys in defaults) {
        NSDictionary *dict_temp = (NSDictionary *)defaults[keys];
        if ([dict_temp isKindOfClass:[NSDictionary class]] && dict_temp != nil) {
            
            if ((options & STOrderStateOptionsPrinted) == STOrderStateOptionsPrinted) {
            
            }
            if ((options & STOrderStateOptionsSigned) == STOrderStateOptionsSigned){
                
            }
            if ((options & STOrderStateOptionsCleared) == STOrderStateOptionsCleared){
                
            }
            [array_result addObject:[STOrderObject mj_objectWithKeyValues:dict_temp]];
        }
    }
    return array_result;
}

@end
