//
//  STOrderDownController.m
//  StatTender
//
//  Created by 高子健 on 17/4/2.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STOrderDownController.h"
#import "STOrderDownCell.h"

@interface STOrderDownController ()<UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, strong) UIButton *btnRoundView;


// 创建订单 - First
@property (nonatomic, strong) UIImageView *backFacImage;

@property (nonatomic, strong) UIImageView *backDateImage;

@property (nonatomic, strong) UITextField *txtFactoryName;

@property (nonatomic, strong) UITextField *txtOrderDate;

@property (nonatomic, strong) UIPickerView *pickerFactory;

@property (nonatomic, strong) UIDatePicker *pickerDate;

@property (nonatomic, strong) UIButton *btnSelected;

@property (nonatomic, strong) UIButton *btnCommit;

@property (nonatomic, strong) UIButton *btnCancel;


// 添加订单 - Secend
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *btnAddOrder;

@property (nonatomic, strong) UIButton *btnCancelOrder;



@property (nonatomic, copy) void(^callBack)(BOOL isShowSelf, BOOL isAuto);


#pragma mark - 订单数据
// 当前选中的订单数据列表
@property (nonatomic, strong) NSMutableArray<STOrderItem *> *arraySelectedOrderItems;


@end

@implementation STOrderDownController

- (instancetype)initWithCallBack:(void(^)(BOOL isShowSelf, BOOL isAuto))callBack
{
    self = [self init];
    if (self) {
        self.callBack = callBack;
        
    }
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor clearColor];
        
        _arraySelectedOrderItems = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackView];
    
    [self addRoundView];
    
    [self addFirstTextFields];
    
}

- (void)addRoundView
{
    if (_btnRoundView == nil) {
        _btnRoundView = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRoundView.layer.cornerRadius = 50;
        _btnRoundView.layer.borderWidth = 5.f;
        _btnRoundView.layer.borderColor = STColorAlpha(44, 44, 44, .2f).CGColor;
        _btnRoundView.clipsToBounds = YES;
        _btnRoundView.backgroundColor = [UIColor cyanColor];
        [_btnRoundView addTarget:self action:@selector(actionRound:) forControlEvents:UIControlEventTouchUpInside];
        _btnRoundView.alpha = NO;
        [self.view addSubview:_btnRoundView];
        [self.view sendSubviewToBack:_btnRoundView];
        
        [_btnRoundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view);
            make.centerY.mas_equalTo(self.view);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(100);
        }];
    }
}

- (void)addBackView
{
    if (_effectView == nil) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.layer.cornerRadius = 20.f;
        _effectView.clipsToBounds = YES;
        [self.view addSubview:_effectView];
        [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(38, 50, 0, 0));
        }];
        [self.view sendSubviewToBack:_effectView];
    }
}

- (void)addFirstTextFields
{
    _backFacImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"whatsnew-button-red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.f, 50.f, 0.f, 50.f) resizingMode:UIImageResizingModeStretch]];
    _backFacImage.userInteractionEnabled = YES;
    [self.effectView addSubview:_backFacImage];
    [_backFacImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.top.mas_equalTo(30);
        make.height.mas_equalTo(50);
    }];
    
    _txtFactoryName = [[UITextField alloc] init];
    _txtFactoryName.placeholder = @"请选择订单的所属单位";
    _txtFactoryName.textColor = [UIColor whiteColor];
    _txtFactoryName.delegate = self;
    [_txtFactoryName addTarget:self action:@selector(actionFactory:) forControlEvents:UIControlEventTouchDown];
    [_backFacImage addSubview:_txtFactoryName];
    [_txtFactoryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_backFacImage).insets(UIEdgeInsetsMake(5, 20, 5, 20));
    }];
    
    _backDateImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"whatsnew-button-red"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.f, 50.f, 0.f, 50.f) resizingMode:UIImageResizingModeStretch]];
    _backDateImage.userInteractionEnabled = YES;
    [self.effectView addSubview:_backDateImage];
    [_backDateImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-50);
        make.top.equalTo(_backFacImage.mas_bottom).offset(30);
        make.height.mas_equalTo(50);
    }];
    
    _txtOrderDate = [[UITextField alloc] init];
    _txtOrderDate.placeholder = @"请选择下单时间（默认当天）";
    _txtOrderDate.textColor = [UIColor whiteColor];
    _txtOrderDate.delegate = self;
    [_txtOrderDate addTarget:self action:@selector(actionDate:) forControlEvents:UIControlEventTouchDown];
    [_backDateImage addSubview:_txtOrderDate];
    [_txtOrderDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_backDateImage).insets(UIEdgeInsetsMake(5, 20, 5, 20));
    }];
    
    
    _btnSelected = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnSelected setTitle:@"确认选择" forState:UIControlStateNormal];
    [_btnSelected setBackgroundColor:STColorAlpha(187, 268, 11, .5f)];
    _btnSelected.layer.cornerRadius = 10.f;
    _btnSelected.titleLabel.font = STFontSystem(20);
    [_btnSelected addTarget:self action:@selector(actionSelected:) forControlEvents:UIControlEventTouchUpInside];
    [_effectView addSubview:_btnSelected];
    
    [_btnSelected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_effectView);
        make.top.equalTo(_txtOrderDate.mas_bottom).offset(30);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(50);
    }];
    
}

#pragma mark - View Move

- (void)moveToSide
{
    CGFloat duration = .5f;
    
    [self addTableView];
    
    [self addBtnAddOrder];
    
    [self addBtnCancelOrder];
    
    [UIView animateWithDuration:duration animations:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:duration animations:^{
                
                _btnRoundView.alpha = YES;
                _tableView.alpha = 1;
                
            }];
        });
        
        [_backFacImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(40);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
        
        [_backDateImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_backFacImage.mas_bottom).offset(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];
    }];
    
}

#pragma mark - Picker

- (void)showFactorysPicker
{
    if (_pickerFactory == nil) {
        _pickerFactory = [[UIPickerView alloc] init];
        _pickerFactory.backgroundColor = STColorAlpha(255, 255, 255, .5f);
        _pickerFactory.delegate = self;
        _pickerFactory.dataSource = self;
        [self.effectView addSubview:_pickerFactory];
        
        [_pickerFactory mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_effectView);
            make.right.mas_equalTo(_effectView);
            make.height.mas_equalTo(150);
            make.bottom.equalTo(_effectView);
        }];
    }
    _pickerFactory.hidden = NO;
}

- (void)showDatePicker
{
    if (_pickerDate == nil) {
        _pickerDate = [[UIDatePicker alloc] init];
        _pickerDate.backgroundColor = STColorAlpha(255, 255, 255, .5f);
        [_pickerDate addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
        [self.effectView addSubview:_pickerDate];
        
        [_pickerDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_effectView);
            make.right.mas_equalTo(_effectView);
            make.height.mas_equalTo(150);
            make.bottom.equalTo(_effectView);
        }];
    }
    _pickerDate.hidden = NO;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [STResourceDataManager fetchFactoryNames].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [STResourceDataManager fetchFactoryNames][row];
}



#pragma mark - TableView

- (void)addTableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = STColorAlpha(128, 1, 128, .1f);
        _tableView.alpha = 0;
        [self.effectView addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_backDateImage.mas_bottom).offset(30);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-200);
        }];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arraySelectedOrderItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STOrderDownCell *cell = [STOrderDownCell cellWithTableViewFromXIB:tableView];
    [cell setDataWithModel:_arraySelectedOrderItems[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    STOrderDownCell *cell = [STOrderDownCell cellWithTableViewFromXIB:tableView];
    [cell setForHeaderView];
    return cell;
}

#pragma mark - Order提交及取消按钮

- (void)addBtnAddOrder
{
    if (_btnAddOrder == nil) {
        _btnAddOrder = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAddOrder setTitle:@"确认订单" forState:UIControlStateNormal];
        [_btnAddOrder setBackgroundColor:STColorAlpha(187, 268, 11, .5f)];
        _btnAddOrder.layer.cornerRadius = 10.f;
        _btnAddOrder.titleLabel.font = STFontSystem(20);
        [_btnAddOrder addTarget:self action:@selector(addOrder:) forControlEvents:UIControlEventTouchUpInside];
        [_effectView addSubview:_btnAddOrder];
        
        [_btnAddOrder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tableView.mas_bottom).offset(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(50);
        }];
    }
}

- (void)addBtnCancelOrder
{
    if (_btnCancelOrder == nil) {
        _btnCancelOrder = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnCancelOrder setTitle:@"取消订单" forState:UIControlStateNormal];
        [_btnCancelOrder setBackgroundColor:STColorAlpha(216, 216, 216, .8f)];
        _btnCancelOrder.layer.cornerRadius = 10.f;
        _btnCancelOrder.titleLabel.font = STFontSystem(20);
        [_btnCancelOrder addTarget:self action:@selector(cancelOrder:) forControlEvents:UIControlEventTouchUpInside];
        [_effectView addSubview:_btnCancelOrder];
        
        [_btnCancelOrder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_btnAddOrder.mas_bottom).offset(20);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(50);
        }];
    }

}

#pragma mark - 数据处理

- (void)setSelecedItem:(STOrderItem *)item
{
    [_arraySelectedOrderItems addObject:item];
    
    [_tableView reloadData];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == _pickerFactory) {
        _txtFactoryName.text = [STResourceDataManager fetchFactoryNames][row];
    }
}


#pragma mark - 事件处理

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return NO;
}

- (void)datePickerAction:(UIDatePicker *)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    _txtOrderDate.text = [df stringFromDate:sender.date];
}

- (void)actionFactory:(UITextField *)sender
{
    _pickerDate.hidden = YES;
    [self showFactorysPicker];
}

- (void)actionDate:(UITextField *)sender
{
    _pickerFactory.hidden = YES;
    [self showDatePicker];
}

- (void)actionSelected:(UIButton *)sender
{
    _pickerDate.hidden = YES;
    _pickerFactory.hidden = YES;
    sender.hidden = YES;
    
    if (self.callBack)
        self.callBack(YES, NO);
}

#pragma Secend

- (void)actionRound:(UIButton *)sender
{
    if (self.callBack)
        self.callBack(YES, YES);
}

/** 确定添加订单操作 */
- (void)addOrder:(UIButton *)sender
{
    STOrderObject *orderObj = [[STOrderObject alloc] init];
    orderObj.orderItems = self.arraySelectedOrderItems;
    
    ReqCloudUpdateOrderObj(orderObj, ^(BOOL isSucceed) {
        
    });
}

- (void)cancelOrder:(UIButton *)sender
{
    STAlertView(@"订单取消",
                @"当前操作：取消正在创建的订单，若点击“确定取消”，该订单取消后将不可被恢复！",
                @"留下继续编辑", @"确定取消", ^(NSUInteger index) {
        if (index) {
            NotificationPost(STNOTIFICATION_CANCEL_NEW_ORDER, self, nil);
            [self.view removeFromSuperview];
        }
    });
}

@end
