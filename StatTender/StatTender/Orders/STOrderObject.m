//
//  STOrderObject.m
//  StatTender
//
//  Created by 高子健 on 17/4/15.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STOrderObject.h"

@implementation STOrderObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _isSigned = NO;
        _isCleared = NO;
        _isPrinted = NO;
        _objectID = @"";
        _orderItems = @[];
        
    }
    return self;
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"orderItems":NSClassFromString(@"STOrderItem")};
}

@end
