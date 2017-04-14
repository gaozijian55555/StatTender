//
//  STResourceDataManager.h
//  StatTender
//
//  Created by 高子健 on 17/4/2.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STResourceDataManager : NSObject

+ (NSMutableArray<STBaseItem *> *)fetchSourceData;

+ (NSArray<NSString *> *)fetchFactoryNames;

@end
