//
//  ViewController.h
//  StatTender
//
//  Created by 高子健 on 17/4/1.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STHostViewController : UIViewController

typedef NS_ENUM(NSUInteger, STEditState) {
    
    /** 模式 - 浏览 */
    STEditStateReading = 10,
    
    /** 模式 - 编辑 */
    STEditStateEdit = 20,
    
    /** 模式 - 选择 */
    STEditStateSelected ,
    
};

@end

