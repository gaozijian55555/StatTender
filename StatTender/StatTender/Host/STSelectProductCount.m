//
//  STSelectProductCount.m
//  StatTender
//
//  Created by 高子健 on 17/4/2.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STSelectProductCount.h"

@interface STSelectProductCount ()

@property (weak, nonatomic) IBOutlet UILabel *lbProductName;

@property (weak, nonatomic) IBOutlet UITextField *txtNumber;

@property (weak, nonatomic) IBOutlet UIButton *btnDown;

@property (weak, nonatomic) IBOutlet UIButton *btnUp;

@property (weak, nonatomic) IBOutlet UIButton *btnCommit;

@property (weak, nonatomic) IBOutlet UIButton *btnCancle;

@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, strong) STOrderItem *orderItem;

@property (nonatomic, copy) void(^callBack)(STOrderItem *orderItem);

@end

@implementation STSelectProductCount

+ (instancetype)showSelProductViewWithBaseItem:(STBaseItem *)item
                                      location:(CGRect)location
                                      callBack:(void(^)(STOrderItem *orderItem))orderItem
{
    STSelectProductCount *selProductView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    selProductView.orderItem = [STOrderItem mj_objectWithKeyValues:item];
    selProductView.callBack = orderItem;
    
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[self class]])
            [view removeFromSuperview];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:selProductView];
    [selProductView resetUI:location];
    [selProductView resetData];
    return selProductView;
}

- (void)resetUI:(CGRect)location
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(location.origin.y);
        make.width.mas_equalTo(650);
        make.height.mas_equalTo(105);
    }];
    
    self.btnUp.layer.cornerRadius = self.btnUp.bounds.size.width *.5f;
    self.btnDown.layer.cornerRadius = self.btnDown.bounds.size.width *.5f;
    self.btnCommit.layer.cornerRadius = 5.f;
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    _effectView.layer.cornerRadius = 20.f;
    _effectView.clipsToBounds = YES;
    [self addSubview:_effectView];
    [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self sendSubviewToBack:_effectView];
    
}

- (void)resetData
{
    _lbProductName.text = [NSString stringWithFormat:@"【%@】%@", [_orderItem.index stringByReplacingOccurrencesOfString:@" " withString:@""], _orderItem.name];
}

- (IBAction)actionDown:(UIButton *)sender {
    
    _txtNumber.text = @([_txtNumber.text floatValue] - 1.f).stringValue;
    
//    sender.enabled = ([[sender titleForState:UIControlStateNormal] floatValue] < 1);
}

- (IBAction)actionUp:(UIButton *)sender {
    
    _txtNumber.text = @([_txtNumber.text floatValue] + 1.f).stringValue;

}

- (IBAction)actionConfirm:(UIButton *)sender {
    
    _orderItem.count = _txtNumber.text;
    
    if (_callBack) _callBack(_orderItem);
    
    [self removeFromSuperview];
}

- (IBAction)actionCancle:(UIButton *)sender {
    [self removeFromSuperview];
}


@end
