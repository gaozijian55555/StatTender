//
//  UITableViewCell+TCFastCell.h
//  eagle
//
//  Created by 高子健 on 16/5/23.
//  Copyright © 2016年 tianchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITableViewExpand <NSObject>

@optional
/**
 私有方法： 不允许外界去主动调用 */
- (void)loadWithComponents;

@end



@interface UITableViewCell (TCFastCell) <UITableViewExpand>

/** 
 *  tableViewCell 构建方法 
 *  必须使用 loadWithComponents 创建cell内的控件
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  tableViewCell 构建方法 XIB */
+ (instancetype)cellWithTableViewFromXIB:(UITableView *)tableView;

/**
 *  tableViewCell 赋值方法 */
- (void)setDataWithModel:(BaseModel *)model;

/** tableViewCell 获取高度方法 */
+ (CGFloat)getCellHeightWithModel:(BaseModel *)model;


@end
