//
//  STProductBaseInfoCell.m
//  StatTender
//
//  Created by 高子健 on 17/4/2.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STProductBaseInfoCell.h"

@interface STProductBaseInfoCell ()

@property (strong, nonatomic) IBOutlet UILabel *lbIndex;

@property (strong, nonatomic) IBOutlet UILabel *lbName;

@property (strong, nonatomic) IBOutlet UILabel *lbFactory;

@property (strong, nonatomic) IBOutlet UILabel *lbModel;

@property (strong, nonatomic) IBOutlet UILabel *lbUnit;

@property (strong, nonatomic) IBOutlet UILabel *lbPrice;

@property (strong, nonatomic) IBOutlet UILabel *lbTip;

@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation STProductBaseInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];

    _lbIndex.adjustsFontSizeToFitWidth = YES;
    _lbName.adjustsFontSizeToFitWidth = YES;
    _lbFactory.adjustsFontSizeToFitWidth = YES;
    _lbModel.adjustsFontSizeToFitWidth = YES;
    _lbUnit.adjustsFontSizeToFitWidth = YES;
    _lbPrice.adjustsFontSizeToFitWidth = YES;
    _lbTip.adjustsFontSizeToFitWidth = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    [self colors:2 alpha:.9f];

}

- (void)setDataWithModel:(STBaseItem *)model
{
    _lbIndex.text = [model.index stringByReplacingOccurrencesOfString:@" " withString:@""];
    _lbName.text = model.name;
    _lbFactory.text = model.factory;
    _lbModel.text = model.model;
    _lbUnit.text = model.unit;
    _lbPrice.text = model.price;
    _lbTip.text = model.tip;
    
}

- (void)setForHeaderView
{
    self.backgroundColor = STColorAlpha(44, 44, 44, .5f);
    
    for (UILabel *view in self.contentView.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            view.font = STFontBold(19);
            
        }
    }
    [self colors:2 alpha:1.f];

//    [self addBlurEffectLine];
}

- (void)colors:(NSInteger)index alpha:(CGFloat)alpha
{
    switch (index) {
        case 1: {
            _lbIndex.backgroundColor = STColorAlpha(175, 18, 88, alpha);
            _lbName.backgroundColor = STColorAlpha(244, 13, 100, alpha);
            _lbFactory.backgroundColor = STColorAlpha(244, 222, 21, alpha);
            _lbModel.backgroundColor = STColorAlpha(179, 197, 35, alpha);
            _lbUnit.backgroundColor = STColorAlpha(90, 13, 67, alpha);
            _lbTip.backgroundColor = STColorAlpha(175, 18, 88, alpha);
        }
            break;
        case 2: {
            _lbIndex.backgroundColor = STColorAlpha(98, 121, 128, alpha);
            _lbName.backgroundColor = STColorAlpha(29, 126, 91, alpha);
            _lbFactory.backgroundColor = STColorAlpha(58, 90, 151, alpha);
            _lbModel.backgroundColor = STColorAlpha(146, 96, 126, alpha);
            _lbUnit.backgroundColor = STColorAlpha(180, 90, 81, alpha);
            _lbPrice.backgroundColor = STColorAlpha(90, 140, 159, alpha);
            _lbTip.backgroundColor = STColorAlpha(105, 91, 146, alpha);
        }
            break;
            
        default:
            break;
    }
}

- (void)addBlurEffectLine
{
    if (_effectView == nil) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [self addSubview:_effectView];
        [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(5);
            make.bottom.equalTo(self).offset(-5);
        }];
        [self sendSubviewToBack:_effectView];
    }
}

@end
