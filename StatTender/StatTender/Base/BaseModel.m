//
//  BaseModel.m
//  Eagle
//
//  Created by 高子健 on 16/8/3.
//  Copyright © 2016年 TC. All rights reserved.
//

#import "BaseModel.h"
#import "RunTime.h"

@implementation BaseModel

+ (NSDictionary *)ObjectClassInArray
{
    return [super mj_objectClassInArray];
}


+ (NSArray *) ObjectArrayWithKeyValuesArray:(NSArray *)array
{
    return [super mj_objectArrayWithKeyValuesArray:array];
}

+ (instancetype) ObjectWithKeyValues:(NSDictionary *)dict
{
    return [super mj_objectWithKeyValues:dict];
}

- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"Description" : @"description"};
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    BaseModel *m_Copy = [[[self class] allocWithZone:zone] init];
    
    NSArray *arrayIvars = [RunTime getIvarList:self];
    
    for (NSDictionary *dictIvar in arrayIvars) {
        NSString *ivarName = dictIvar[@"name"];
        NSString *ivarValue = [RunTime getIvarValue:self ivarName:dictIvar[@"name"]];
        if ([((NSString *)dictIvar[@"attribute"]) rangeOfString:@"NSNumber"].location != NSNotFound) {
            [RunTime setIvarValue:m_Copy ivarName:ivarName value:[ivarValue copy]];
        }
        else {
            [RunTime setIvarValue:m_Copy ivarName:ivarName value:[ivarValue mutableCopy]];
        }
    }
    
    return m_Copy;
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseModel *copy = [[[self class] allocWithZone:zone] init];
    
    NSArray *arrayIvars = [RunTime getIvarList:self];
    
    for (NSDictionary *dictIvar in arrayIvars) {
        NSString *ivarName = dictIvar[@"name"];
        NSString *ivarValue = [RunTime getIvarValue:self ivarName:dictIvar[@"name"]];
        [RunTime setIvarValue:copy ivarName:ivarName value:[ivarValue copy]];
    }
    
    return copy;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    
    NSArray *arrayIvars = [RunTime getIvarList:self];
    
    for (NSDictionary *dictIvar in arrayIvars) {
        NSString *ivarName = dictIvar[@"name"];
        NSString *ivarValue = [RunTime getIvarValue:self ivarName:dictIvar[@"name"]];
        [encoder encodeObject:ivarValue forKey:ivarName];
    }
    
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        
        NSArray *arrayIvars = [RunTime getIvarList:self];
        
        for (NSDictionary *dictIvar in arrayIvars) {
            NSString *ivarName = dictIvar[@"name"];
            [RunTime setIvarValue:self ivarName:ivarName value:[decoder decodeObjectForKey:ivarName]];
        }
    }
    
    return self;
}

@end
