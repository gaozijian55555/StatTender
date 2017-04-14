//
//  UITabBarController+RootTabBarController.m
//  Eagle
//
//  Created by 高子健 on 16/8/4.
//  Copyright © 2016年 TC. All rights reserved.
//

#import "UITabBarController+RootTabBarController.h"

@implementation UITabBarController (RootTabBarController)


- (void)setTabBarHidden:(BOOL)hiden animated:(BOOL)animated
{
    hiden?[self hideTabBarAnimated:animated]:[self showTabBarAnimated:animated];
}

- (void)hideTabBarAnimated:(BOOL)animated
{
    [UIView animateWithDuration:animated?UINavigationControllerHideShowBarDuration:0 animations:^{
        CGFloat ScreenH = [UIScreen mainScreen].bounds.size.height;
        for(UIView *view in self.view.subviews)
        {
            if([view isKindOfClass:[UITabBar class]])
            {
                if (ScreenH<view.frame.origin.y) return ;
                [view setFrame:CGRectMake(view.frame.origin.x,
                                          view.frame.origin.y + 50,
                                          view.frame.size.width,
                                          view.frame.size.height)];
            }
            else
            {
                [view setFrame:CGRectMake(view.frame.origin.x,
                                          view.frame.origin.y,
                                          view.frame.size.width,
                                          view.frame.size.height + 50)];
            }
        }
    }];
}

- (void)showTabBarAnimated:(BOOL)animated
{
    [UIView animateWithDuration:animated?UINavigationControllerHideShowBarDuration:0 animations:^{
        CGFloat ScreenH = [UIScreen mainScreen].bounds.size.height;
        for(UIView *view in self.view.subviews)
        {
            if([view isKindOfClass:[UITabBar class]])
            {
                if (ScreenH>view.frame.origin.y) return ;
                [view setFrame:CGRectMake(view.frame.origin.x,
                                          view.frame.origin.y - 50,
                                          view.frame.size.width,
                                          view.frame.size.height)];
            }
            else
            {
                [view setFrame:CGRectMake(view.frame.origin.x,
                                          view.frame.origin.y,
                                          view.frame.size.width,
                                          view.frame.size.height - 50)];
            }
        }
    }];
}

@end
