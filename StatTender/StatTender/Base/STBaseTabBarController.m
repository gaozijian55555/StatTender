//
//  STBaseTabBarController.m
//  StatTender
//
//  Created by 高子健 on 17/4/8.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STBaseTabBarController.h"
#import "STHostViewController.h"
#import "STOrdersHostViewController.h"
#import "STPersonalHostViewController.h"

@interface STBaseTabBarController ()

@end

@implementation STBaseTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIViewController *host = [[STHostViewController alloc] init];
        UIViewController *ordersHost = [[STOrdersHostViewController alloc] init];
        UIViewController *personalHost = [[STPersonalHostViewController alloc] init];
        self.viewControllers = @[[[UINavigationController alloc] initWithRootViewController:host], [[UINavigationController alloc] initWithRootViewController:ordersHost], [[UINavigationController alloc] initWithRootViewController:personalHost]];
        host.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"标书" image:[UIImage imageNamed:@"nav-calligraphy-sel"] selectedImage:[UIImage imageNamed:@"nav-calligraphy-zoom"]];
        ordersHost.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"订单" image:[UIImage imageNamed:@"nav-calligraphy-sel"] selectedImage:[UIImage imageNamed:@"nav-calligraphy-zoom"]];
        personalHost.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"nav-calligraphy-sel"] selectedImage:[UIImage imageNamed:@"nav-calligraphy-zoom"]];

        
    }
    return self;
}

//处理因为隐藏导航栏后 点击 tabbar 切换 时 控制器 顶部会出现跳动的问题
-(void)setSelectedViewController:(__kindof UIViewController *)selectedViewController
{
    //    if ([self.viewControllers indexOfObject:selectedViewController] != 2) {
    UINavigationController * nav = (UINavigationController *)selectedViewController;
    if (nav.viewControllers.count == 1) {
        [nav setNavigationBarHidden:YES animated:NO];
        //        }
        NSLog(@"当前选中的是服务");
    }
    
    [super setSelectedViewController:selectedViewController];
}

@end
