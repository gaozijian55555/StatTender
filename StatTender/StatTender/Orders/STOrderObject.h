//
//  STOrderObject.h
//  StatTender
//
//  Created by 高子健 on 17/4/15.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STOrderObject : NSObject

// 订单编号<若订单已上传到云端，必有此字段； 否者为本地订单>
@property (nonatomic, copy) NSString *objectID;

// 订单内容
@property (nonatomic, strong) NSArray<STOrderItem *> *orderItems;

// 是否被打印
@property (nonatomic, assign) BOOL isPrinted;

// 是否已签单
@property (nonatomic, assign) BOOL isSigned;

// 是否已结算
@property (nonatomic, assign) BOOL isCleared;

@end
