//
//  STHostSearchBar.m
//  StatTender
//
//  Created by 高子健 on 17/5/14.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STHostSearchBar.h"

@interface STHostSearchBar ()

@property (nonatomic, strong) UIVisualEffectView *effectView;


@property (nonatomic, strong) UIImageView *imgLeft;

@property (nonatomic, strong) UITextField *txtSearch;

@end

@implementation STHostSearchBar

- (void)addEffectView
{
    if (_effectView == nil) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        [self addSubview:_effectView];
        
        [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
}

- (void)addImgLeft
{
    if (_imgLeft == nil) {
        UIImage *image = [UIImage imageNamed:@"Search_Map_Icon"];
        _imgLeft = [[UIImageView alloc] initWithImage:image];
        [_effectView addSubview:_imgLeft];
        
        [_imgLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(50);
            make.width.mas_equalTo(image.size.width);
            make.height.mas_equalTo(image.size.height);
        }];
    }
}

- (void)addTxtSearch
{
    if (_txtSearch == nil) {
        _txtSearch = [[UITextField alloc] init];
        _txtSearch.textColor = STColor(44, 44, 44);
        _txtSearch.font = STFontSystem(16);
        _txtSearch.placeholder = @"请输入要查询的商品名称";
        _txtSearch.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_txtSearch addTarget:self action:@selector(textFieldContentDidChanged:) forControlEvents:UIControlEventEditingChanged];
        [_effectView addSubview:_txtSearch];
        
        [_txtSearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_imgLeft.mas_right).offset(50);
            make.height.equalTo(_effectView);
            make.centerY.equalTo(_effectView);
            make.right.equalTo(_effectView.mas_right).offset(-50);
        }];
    }
}

+ (instancetype)createSearchBar
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        [self addEffectView];
        [self addImgLeft];
        [self addTxtSearch];

        self.layer.cornerRadius = 20.f;
        self.layer.borderWidth = 1.f;
        self.layer.borderColor = STColor(224, 224, 224).CGColor;
        self.clipsToBounds = YES;
        
    }
    return self;
}

- (void)cancelFirstResponse
{
    [self endEditing:YES];
}

- (void)setDelegate:(id<STSearchBarDelegate>)delegate
{
    _delegate = delegate;
    _txtSearch.delegate = delegate;
}

- (NSString *)text
{
    return self.txtSearch.text;
}

- (void)textFieldContentDidChanged:(UITextField *)sender
{
    if ([self.delegate respondsToSelector:@selector(textFieldContentDidChanged:)])
        [self.delegate textFieldContentDidChanged:sender];
}

@end
