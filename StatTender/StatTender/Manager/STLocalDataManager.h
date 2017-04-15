//
//  STLocalDataManager.h
//  StatTender
//
//  Created by 高子健 on 17/4/15.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STLocalDataManager : NSObject

+ (instancetype)manager;

- (BOOL)saveLocalDataWithOrderDict:(NSDictionary *)orderDict;

@end
