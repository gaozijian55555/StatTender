//
//  STLeanCloudManager.h
//  StatTender
//
//  Created by 高子健 on 17/4/15.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LeanCloudResult)(BOOL succeeded, NSError *error);

@interface STLeanCloudManager : NSObject

+ (instancetype)manager;

/**
 向 LeanCloud 提交 OrderObject

 @param orderObject orderObject
 @param result      上传结果
 @return AVObject   数据体对象
 */
- (AVObject *)reqCloudToUpdateOrder:(STOrderObject *)orderObject result:(LeanCloudResult)result;

@end

CG_INLINE AVObject *ReqCloudUpdateOrderObj(STOrderObject *orderObj, LeanCloudResult result) {
    return [[STLeanCloudManager manager] reqCloudToUpdateOrder:orderObj result:result];
};
