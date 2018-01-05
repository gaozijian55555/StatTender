//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//
#define Tag 989
#import "MBProgressHUD+MJ.h"
#import "AppDelegate.h"

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view{
    if (view == nil) view = [self getRootWindow];
    UIView  * tagView  =[view viewWithTag:Tag];
    if (tagView) {
        return;
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.tag = Tag;
    hud.labelText = text;
    
    hud.labelFont=[UIFont systemFontOfSize:18];
    
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.opacity=0.7;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1.8 秒之后再消失
    [hud hide:YES afterDelay:1.8];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [self getRootWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.opacity=0.7;
    
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message{
    return [self showMessage:message toView:nil];
}

+ (MBProgressHUD *)showLoading{
    return [self showLoadingtoView:nil];
}

+ (UIView *)getRootView{
    UIWindow *window=[self getRootWindow];
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    UIViewController *result = nil;
    if ([nextResponder isKindOfClass:[UIViewController class]]){
        result = nextResponder;
    }else{
        result = window.rootViewController;
    }
    return result.view;
}

+ (UIWindow *)getRootWindow{
    NSArray *windows = [UIApplication sharedApplication].windows;
    AppDelegate *delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds)&&window==delegate.window)
            
            return window;
    }
    return [[UIApplication sharedApplication].delegate window];
}

+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) view = [self getRootWindow];
    
//    view = App_TheFrontNavC.view;
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUDForMessage{
    [self hideHUDForView:nil];
}

+ (void)hideHUD{
    NSEnumerator *subviewsEnum = [[self getRootView].subviews reverseObjectEnumerator];
    
//    NSEnumerator *subviewsEnum = [App_TheFrontNavC.view.subviews reverseObjectEnumerator];

    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            MBProgressHUD *hud=(MBProgressHUD *)subview;
            if (hud.mode == MBProgressHUDModeCustomView) {
                for (id view in hud.customView.subviews) {
                    if ([view isKindOfClass:[UIImageView class]]) {
                        hud.removeFromSuperViewOnHide = YES;
                        [hud hide:YES];
                    }
                }
            }
        }
    }
}


+ (void)showMessageForDelay:(NSString *)message
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self getRootView] animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    //    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
    
}

@end
