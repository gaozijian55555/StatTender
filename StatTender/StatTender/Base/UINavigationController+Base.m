//
//  UINavigationController+Base.m
//  StatTender
//
//  Created by 高子健 on 17/4/2.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "UINavigationController+Base.h"

@implementation UINavigationController (Base)

+ (void)initialize
{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
    // 注意导航条上按钮不可能，用模型的文字属性设置是不好使
    //    // 设置不可用
    titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateHighlighted];
}

@end
