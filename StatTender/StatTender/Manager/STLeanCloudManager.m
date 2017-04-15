//
//  STLeanCloudManager.m
//  StatTender
//
//  Created by 高子健 on 17/4/15.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STLeanCloudManager.h"

static STLeanCloudManager *manager = nil;

@implementation STLeanCloudManager

+ (instancetype)manager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (AVObject *)reqCloudToUpdateOrder:(STOrderObject *)orderObject result:(LeanCloudResult)result
{
    NSMutableDictionary *dictOrderObject = [orderObject mj_keyValues];
    
    AVObject *cloudOrders = [[AVObject alloc] initWithClassName:@"Orders"];
    [cloudOrders setObject:dictOrderObject[@"isCleared"] forKey:@"isCleared"];
    [cloudOrders setObject:dictOrderObject[@"isSigned"] forKey:@"isSigned"];
    [cloudOrders setObject:dictOrderObject[@"isPrinted"] forKey:@"isPrinted"];
    [cloudOrders setObject:dictOrderObject[@"objectID"] forKey:@"objectID"];
    [cloudOrders setObject:dictOrderObject[@"orderItems"] forKey:@"orderItems"];
    
    [cloudOrders saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [dictOrderObject setObject:cloudOrders.objectId forKey:@"objectID"];
        
    }];
    
    return cloudOrders;
}

@end
