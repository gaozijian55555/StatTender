//
//  STOrderShowCell.m
//  StatTender
//
//  Created by 高子健 on 17/5/14.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STOrderShowCell.h"
#import "STOrderDownCell.h"

@interface STOrderShowCell ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lbFactoryName;

@property (weak, nonatomic) IBOutlet UILabel *lbDate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) STOrderObject *orderObj;


@end

@implementation STOrderShowCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _tableView.backgroundColor = [UIColor clearColor];
    
    self.layer.cornerRadius = 20;
    self.backgroundColor = STColorAlpha(255, 244, 244, .8f);
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setDataWithModel:(STOrderObject *)orderObj
{
    self.orderObj = orderObj;
    
    self.lbFactoryName.text = _orderObj.companyName;
    
    self.lbDate.text = _orderObj.downAt;
    
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.orderObj.orderItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    STOrderDownCell *cell = [STOrderDownCell cellWithTableViewFromXIB:tableView];
    [cell setDataWithModel:self.orderObj.orderItems[indexPath.row]];
    [cell setForOrderShow];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 33;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    STOrderDownCell *cell = [STOrderDownCell cellWithTableViewFromXIB:tableView];
    [cell setForHeaderView];
    [cell setForOrderShow];
    return cell;
}

@end
