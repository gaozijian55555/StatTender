//
//  STOrderItem.h
//  StatTender
//
//  Created by 高子健 on 17/4/2.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STOrderItem : STBaseItem

/** 产品数量 */
@property (nonatomic, copy) NSString *count;

/** 是否已退货 */
@property (nonatomic, assign) BOOL isRefund;

@end
