//
//  STToolBaseClass.h
//  StatTender
//
//  Created by 高子健 on 17/4/15.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "MBProgressHUD+MJ.h"

@interface STToolBaseClass : NSObject

+ (instancetype)manager;


/** *提示弹窗 快捷方式 otherButtonTitles类型:NSString或NSArray */
- (UIAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(id)otherButtonTitles callBack:(void(^)(NSUInteger index))callBack;

/** *底部弹窗 快捷方式 otherButtonTitles类型:NSString或NSArray */
- (UIActionSheet *)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(id)otherButtonTitles callBack:(void (^)(NSUInteger))callBack;

@end

/** Tool: Alert快捷方式, otherButtonTitles类型:NSString或NSArray ,点击取消的返回值为 0 */
CG_INLINE UIAlertView *STAlertView(NSString *title, NSString *message, NSString *cancelButtonTitle, id otherButtonTitle, void(^callBack)(NSUInteger index)){
    return [[STToolBaseClass manager] alertWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle callBack:^(NSUInteger index) {
        callBack(index);
    }];
}

/** Tool: ActionSheet快捷方式, otherButtonTitles类型:NSString或NSArray */
CG_INLINE UIActionSheet *STActionSheet(NSString *title, NSString *cancelButtonTitle, NSString *destructiveButtonTitle, id otherButtonTitles, void(^callBack)(NSUInteger index)){
    return [[STToolBaseClass manager] actionSheetWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles callBack:^(NSUInteger index) {
        callBack(index);
    }];
}

/** Toast - 遮罩提示 - Succeed */
CG_INLINE void ToastShowSucceed(NSString *message) {
    [MBProgressHUD showSuccess:message];
}

/** Toast - 遮罩提示 - Error */
CG_INLINE void ToastShowError(NSString *message) {
    [MBProgressHUD showError:message];
}

/** Toast - 纯文字提示 */
CG_INLINE void ToastShowMessage(NSString *message) {
    [MBProgressHUD showMessageForDelay:message];
}

