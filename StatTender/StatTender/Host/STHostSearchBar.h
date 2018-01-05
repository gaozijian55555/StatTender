//
//  STHostSearchBar.h
//  StatTender
//
//  Created by 高子健 on 17/5/14.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol STSearchBarDelegate <UITextFieldDelegate>

@optional
- (void)textFieldContentDidChanged:(UITextField *)textField;

@end

@interface STHostSearchBar : UIView

+ (instancetype)createSearchBar;

// 取消键盘
- (void)cancelFirstResponse;

@property (nonatomic, assign) id<STSearchBarDelegate> delegate;

@property (nonatomic, strong) NSString *text;


@end
