//
//  STSelectProductCount.h
//  StatTender
//
//  Created by 高子健 on 17/4/2.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STOrderItem.h"

@interface STSelectProductCount : UIView

/**
 展示产品选择视图

 @param item 选择产品模型
 @param location 位置
 @param orderItem 下单的商品模型
 */
+ (instancetype)showSelProductViewWithBaseItem:(STBaseItem *)item
                                      location:(CGRect)location
                                      callBack:(void(^)(STOrderItem *orderItem))orderItem;

@end
