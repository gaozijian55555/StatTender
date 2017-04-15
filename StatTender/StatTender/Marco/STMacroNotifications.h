//
//  STMacroNotifications.h
//  StatTender
//
//  Created by 高子健 on 17/4/15.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import <Foundation/Foundation.h>

CG_INLINE void NotificationRegister(NSString *name, id observer, SEL selector, id object) {
    
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:name object:object];
}

CG_INLINE void NotificationPost(NSString *name, id object, NSDictionary *userInfo) {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}

CG_INLINE void NotificationRemove(NSString *name, id observer, id object) {
    
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:name object:object];
}

CG_INLINE void NotificationRemoveAll(id observer) {
    
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}


/* 宏定义__发送通知 */
#define TCPOST_NOTIFICATION_NAMED_(n)           [[NSNotificationCenter defaultCenter] postNotificationName:n object:nil]
#define TCPOST_NOTIFICATION_NAMED_OBJECT(n, o)  [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]


/* 通知类型 */

/**
 通知: 添加了新的订单 */
UIKIT_EXTERN NSString *const STNOTIFICATION_ADD_NEW_ORDER;

/**
 通知: 取消了新的订单 */
UIKIT_EXTERN NSString *const STNOTIFICATION_CANCEL_NEW_ORDER;


@interface STMacroNotifications : NSObject

@end
