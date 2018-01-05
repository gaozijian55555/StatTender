//
//  STOrderDownCell.m
//  StatTender
//
//  Created by 高子健 on 17/4/2.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STOrderDownCell.h"

@interface STOrderDownCell ()

@property (strong, nonatomic) IBOutlet UILabel *lbIndex;

@property (strong, nonatomic) IBOutlet UILabel *lbName;

@property (strong, nonatomic) IBOutlet UILabel *lbUnit;

@property (strong, nonatomic) IBOutlet UILabel *lbCount;

@property (strong, nonatomic) IBOutlet UILabel *lbPrice;

@property (strong, nonatomic) IBOutlet UILabel *lbPriceCount;

@end

@implementation STOrderDownCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _lbIndex.adjustsFontSizeToFitWidth = YES;
    _lbName.adjustsFontSizeToFitWidth = YES;
    _lbUnit.adjustsFontSizeToFitWidth = YES;
    _lbCount.adjustsFontSizeToFitWidth = YES;
    _lbPrice.adjustsFontSizeToFitWidth = YES;
    _lbPriceCount.adjustsFontSizeToFitWidth = YES;
}

- (void)setDataWithModel:(STOrderItem *)model
{
    _lbIndex.text = [model.index stringByReplacingOccurrencesOfString:@" " withString:@""];
    _lbName.text = model.name;
    _lbUnit.text = model.unit;
    _lbCount.text = model.count;
    _lbPrice.text = model.price;
    _lbPriceCount.text = [@([model.count floatValue] * [model.price floatValue]) stringValue];
}

- (void)setForHeaderView
{
    self.backgroundColor = STColorAlpha(44, 44, 44, .5f);
    
    for (UILabel *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            view.font = STFontBold(17);
        }
    }
}

- (void)setForOrderShow
{
    
    for (UILabel *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            view.backgroundColor = [UIColor clearColor];
            view.layer.borderColor = STColor(0, 0, 0).CGColor;
            view.textColor = STColor(0, 0, 0);
            view.layer.borderWidth = .1f;
        }
    }
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
