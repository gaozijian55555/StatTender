//
//  STLeanCloudManager.m
//  StatTender
//
//  Created by 高子健 on 17/4/15.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STLeanCloudManager.h"
#import "RunTime.h"

/** 数据库-Orders表 */
#define dbOrders @"Orders"



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
    if (orderObject.objectID.length) {
        NSMutableDictionary *dictOrderObject = [orderObject mj_keyValues];

        AVObject *cloudOrders =[AVObject objectWithClassName:dbOrders objectId:dictOrderObject[@"objectID"]];
        
        NSArray *arrayIvars = [RunTime getIvarList:self];
        for (NSDictionary *dictIvar in arrayIvars) {    // 遍历全部KEY 进行上传
            NSString *ivarName = dictIvar[@"name"];
            [cloudOrders setObject:dictOrderObject[ivarName] forKey:ivarName];
        }
        
        // 保存到云端
        [cloudOrders saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (result) result(succeeded, error);
        }];
        
        return cloudOrders;
    }
    else {
        NSMutableDictionary *dictOrderObject = [orderObject mj_keyValues];
        
        AVObject *cloudOrders = [[AVObject alloc] initWithClassName:dbOrders];
        
        NSArray *arrayIvars = [RunTime getIvarList:self];
        for (NSDictionary *dictIvar in arrayIvars) {    // 遍历全部KEY 进行上传
            NSString *ivarName = dictIvar[@"name"];
            [cloudOrders setObject:dictOrderObject[ivarName] forKey:ivarName];
        }
        
        [cloudOrders saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            [dictOrderObject setObject:cloudOrders.objectId forKey:@"objectID"];
            if (result) result(succeeded, error);
        }];
        
        return cloudOrders;
    }
}

@end
