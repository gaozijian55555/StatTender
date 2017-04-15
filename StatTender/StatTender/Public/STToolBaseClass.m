//
//  STToolBaseClass.m
//  StatTender
//
//  Created by 高子健 on 17/4/15.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STToolBaseClass.h"

static STToolBaseClass *manager = nil;

@interface STToolBaseClass ()<UIAlertViewDelegate, UIActionSheetDelegate>

@property (nonatomic, copy) void(^callBack)(NSUInteger index);


@end

@implementation STToolBaseClass

+ (instancetype)manager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (UIAlertView *)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable id)otherButtonTitles callBack:(void (^)(NSUInteger))callBack
{
    self.callBack = callBack;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    if ([otherButtonTitles isKindOfClass:[NSArray class]]) {
        for (NSString *otherTitle in otherButtonTitles) {
            [alert addButtonWithTitle:otherTitle];
        }
    }
    else if ([otherButtonTitles isKindOfClass:[NSString class]]) {
        [alert addButtonWithTitle:otherButtonTitles];
    }
    
    [alert show];
    
    return alert;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.callBack) {
        self.callBack(buttonIndex);
    }
}

- (UIActionSheet *)actionSheetWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(id)otherButtonTitles callBack:(void (^)(NSUInteger))callBack
{
    self.callBack = callBack;
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles: nil];
    //    sheet.cancelButtonIndex = 0;
    //    sheet.destructiveButtonIndex = 1;
    if ([otherButtonTitles isKindOfClass:[NSArray class]]) {
        for (NSString *otherTitle in otherButtonTitles) {
            [sheet addButtonWithTitle:otherTitle];
        }
    }
    else if ([otherButtonTitles isKindOfClass:[NSString class]]) {
        [sheet addButtonWithTitle:otherButtonTitles];
    }
    
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
    return sheet;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.callBack) {
        self.callBack(buttonIndex);
    }
}

@end
