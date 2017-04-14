//
//  UITableViewCell+TCFastCell.m
//  eagle
//
//  Created by 高子健 on 16/5/23.
//  Copyright © 2016年 tianchuang. All rights reserved.
//

#import "UITableViewCell+TCFastCell.h"

@implementation UITableViewCell (TCFastCell)

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTCCellIdentifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTCCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadWithComponents];
    }
    return cell;
}

/**
 *  tableViewCell 布局cell
 */
- (void)loadWithComponents
{
    
}

+ (instancetype)cellWithTableViewFromXIB:(UITableView *)tableView
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTCCellIdentifier];
    
    if(cell == nil){
        cell = [self viewFromXIB];
    }
    
    return cell;

}

/**
 *  自动从xib创建视图
 */
+(instancetype)viewFromXIB {
    
    UITableViewCell *xibCell = [[[NSBundle mainBundle] loadNibNamed:kTCCellIdentifier owner:nil options:nil] firstObject];
    
    if(xibCell == nil){
        NSLog(@"CoreXibView：从xib创建视图失败，当前类是：%@", kTCCellIdentifier);
    }
    
    return xibCell;
}

- (void)setDataWithModel:(BaseModel *)model
{
    
}

+ (CGFloat)getCellHeightWithModel:(BaseModel *)model
{
    return 0;
}

@end
