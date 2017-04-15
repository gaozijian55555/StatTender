//
//  ViewController.m
//  StatTender
//
//  Created by 高子健 on 17/4/1.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STHostViewController.h"
#import "STResourceDataManager.h"
#import "STProductBaseInfoCell.h"
#import "STOrderDownController.h"
#import "STSelectProductCount.h"
#import "UITabBarController+RootTabBarController.h"

static BOOL isShowOrderView = YES;

@interface STHostViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    CGFloat _orderSideWidth ; // 订单视图宽度
    
    STEditState _editState ; // 当前编辑状态
}
// 列表头显示样式--总数据
@property (nonatomic, strong) STBaseItem *listTitleModel;

@property (nonatomic, strong) NSArray<STBaseItem *> *allData;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) STOrderDownController *orderDownVC;

@property (nonatomic, assign) BOOL isHideStatusBar;

@end

@implementation STHostViewController

- (void)addTableView
{
    if (_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self registerObservers];

        _listTitleModel = [[STBaseItem alloc] init];
        _listTitleModel.index = @"序号";
        _listTitleModel.name = @"品     名";
        _listTitleModel.factory = @"生产厂家";
        _listTitleModel.model = @"型号";
        _listTitleModel.unit = @"单位";
        _listTitleModel.price = @"单价(元)";
        _listTitleModel.tip = @"备     注";
        
        _isHideStatusBar = NO;
        self.title = @"文具、办公用品用品 & 电脑耗材价格表";
        
        _editState = STEditStateReading;
        _orderSideWidth = 400;

        
    }
    return self;
}

- (void)registerObservers
{
    NotificationRegister(STNOTIFICATION_CANCEL_NEW_ORDER, self, @selector(newOrderChanged:), nil);
}

- (void)newOrderChanged:(NSNotification *)not
{
    _editState = STEditStateReading;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItems];
    
    _allData = [STResourceDataManager fetchSourceData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addTableView];
}

- (void)setNavigationItems
{
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add-notebook-quick-create-set"] style:UIBarButtonItemStyleDone target:self action:@selector(setAction:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"finder-icon-new"] style:UIBarButtonItemStyleDone target:self action:@selector(ordersAction:)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STProductBaseInfoCell *cell = [STProductBaseInfoCell cellWithTableViewFromXIB:tableView];
    [cell setDataWithModel:_allData[indexPath.row]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    STProductBaseInfoCell *headView = [STProductBaseInfoCell cellWithTableViewFromXIB:tableView];
    [headView setDataWithModel:self.listTitleModel];
    [headView setForHeaderView];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    CGRect location = [tableView rectForRowAtIndexPath:indexPath];
    location.origin.y -= tableView.contentOffset.y - tableView.visibleCells.firstObject.contentView.frame.size.height;
    
    if (_editState == STEditStateSelected) {
        [STSelectProductCount showSelProductViewWithBaseItem:_allData[indexPath.row] location:location callBack:^(STOrderItem *orderItem) {
            
            [_orderDownVC setSelecedItem:orderItem];
            
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    if (_editState == STEditStateSelected && isShowOrderView == YES)
//        [self showOrderDownView:NO];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (scrollView == _tableView) {
        [self.navigationController setNavigationBarHidden:(velocity.y > 0) animated:YES];
        [self.tabBarController setTabBarHidden:(velocity.y > 0) animated:YES];
        
        _isHideStatusBar = (velocity.y > 0);
        [self setNeedsStatusBarAppearanceUpdate];
        [self prefersStatusBarHidden];
        
    }
}

//隐藏单个页面电池条的方法
- (BOOL)prefersStatusBarHidden
{
    return _isHideStatusBar;
}

#pragma mark - Actions

- (void)setAction:(UIButton *)sender
{


}

- (void)ordersAction:(UIButton *)sender
{
    if (_editState == STEditStateReading)
        [self showOrderDownView:(isShowOrderView)];
}

- (void)showOrderDownView:(BOOL)isShow;
{
    
    isShowOrderView = isShow;
    __weak typeof(self) weakSelf = self;
    
    if (_orderDownVC == nil) {
        _orderDownVC = [[STOrderDownController alloc] initWithCallBack:^(BOOL isShowSelf, BOOL isAuto) {
            if (isAuto == YES)
                [weakSelf showOrderDownView:isShowOrderView];
            else
                [weakSelf showOrderDownView:isShowSelf];
        }];
        _orderDownVC.view.frame = CGRectMake(ScreenWidth - 30, 30, 30, 30);
        [self.view addSubview:_orderDownVC.view];
        
        [UIView animateWithDuration:.25f animations:^{
            [_orderDownVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(430);
                make.width.mas_equalTo(600);
                make.center.mas_equalTo(self.view);
            }];
            [_orderDownVC.view layoutIfNeeded];
            [self.view layoutIfNeeded];
        }];
        
        _editState = STEditStateEdit;
    }
    else {

        [_orderDownVC moveToSide];
        _editState = STEditStateSelected;

        if (isShowOrderView)
            [UIView animateWithDuration:.5 animations:^{
                
                [_orderDownVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.view.mas_right).offset(-_orderSideWidth);
                    make.top.mas_equalTo(self.view);
                    make.bottom.mas_equalTo(self.view);
                    make.width.mas_equalTo(_orderSideWidth);
                }];
                [_orderDownVC.view layoutIfNeeded];
                [self.view layoutIfNeeded];
            }];
        else
            [UIView animateWithDuration:.5 animations:^{
                
                [_orderDownVC.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.view.mas_right).offset(-50);
                    make.top.mas_equalTo(self.view);
                    make.bottom.mas_equalTo(self.view);
                    make.width.mas_equalTo(_orderSideWidth);
                }];
                [_orderDownVC.view layoutIfNeeded];
                [self.view layoutIfNeeded];
                
            }];
        isShowOrderView = !isShowOrderView;
    }
}


@end
