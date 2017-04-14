//
//  BaseModel.h
//  Eagle
//
//  Created by 高子健 on 16/8/3.
//  Copyright © 2016年 TC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface BaseModel : NSObject

/** 设置数组字段 对应的模型类名称 */
+ (NSDictionary *) ObjectClassInArray;

/** 字典 --> 模型 */
+ (instancetype) ObjectWithKeyValues:(NSDictionary *)dict;

/** 字典数组 --> 模型数组 */
+ (NSMutableArray *) ObjectArrayWithKeyValuesArray:(NSArray *)array;

@end
