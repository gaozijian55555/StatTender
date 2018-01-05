//
//  STOrderDownController.h
//  StatTender
//
//  Created by 高子健 on 17/4/2.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STOrderDownController : UIViewController

- (instancetype)initWithCallBack:(void(^)(BOOL isShowSelf, BOOL isAuto))callBack;

- (void)moveToSide;

/**
 @param item 传入选中的订单模型 */
- (void)setSelecedItem:(STOrderItem *)item;

@end
