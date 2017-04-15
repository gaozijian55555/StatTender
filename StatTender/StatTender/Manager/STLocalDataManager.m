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

- (BOOL)saveLocalDataWithOrderDict:(NSDictionary *)orderDict
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];

    [df setObject:orderDict forKey:orderDict[@"objectID"]];
    
    
}

@end
