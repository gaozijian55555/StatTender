//
//  STBaseItem.h
//  StatTender
//
//  Created by 高子健 on 17/4/1.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STBaseItem : BaseModel
// 序号
@property (nonatomic, copy) NSString *index;
// 品名
@property (nonatomic, copy) NSString *name;
// 厂家
@property (nonatomic, copy) NSString *factory;
// 型号
@property (nonatomic, copy) NSString *model;
// 单位
@property (nonatomic, copy) NSString *unit;
// 单价
@property (nonatomic, copy) NSString *price;
// 备注
@property (nonatomic, copy) NSString *tip;
// 热门等级（0/1/...）
@property (nonatomic, copy) NSString *hotLevel;

@end
