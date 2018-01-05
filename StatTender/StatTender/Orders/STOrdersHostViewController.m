//
//  STOrdersHostViewController.m
//  StatTender
//
//  Created by 高子健 on 17/4/8.
//  Copyright © 2017年 高子建. All rights reserved.
//

#import "STOrdersHostViewController.h"
#import "STOrderShowCell.h"

@interface STOrdersHostViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UISegmentedControl *segmentView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *arrayData;

@end

@implementation STOrdersHostViewController

- (UISegmentedControl *)segmentView
{
    if (_segmentView == nil) {
        _segmentView = [[UISegmentedControl alloc] initWithItems:@[@"全部订单", @"未打印", @"未签单", @"未结算", @"其他筛选"]];
        _segmentView.selectedSegmentIndex = 0;
    }
    return _segmentView;
}

- (NSMutableArray *)arrayData
{
    if (_arrayData == nil) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
     
        self.view.backgroundColor = STColor(224, 224, 224);
    }
    return self;
}

- (void)setBackEffectView
{
    NSString *imgPath = [[NSBundle mainBundle] pathForResource:@"timg" ofType:@"jpeg"];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imgPath]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self.view addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = self.segmentView;

    [self setBackEffectView];
    
    [self addCollectionView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.arrayData = [NSMutableArray arrayWithArray:[[STLocalDataManager manager] fetchAllOrders]];

    [self.collectionView reloadData];
}

- (void)addCollectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 20;
        flowLayout.minimumInteritemSpacing = 20;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"STOrderShowCell" bundle:nil]forCellWithReuseIdentifier:@"STOrderShowCell"];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.scrollEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [self.view addSubview:_collectionView];

        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(50, 0, 150, 0));
        }];
    }
}

#pragma mark -- UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(600, 510);
}

#pragma mark- UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.arrayData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //自营服务的collection cell
    STOrderShowCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"STOrderShowCell" forIndexPath:indexPath];
    [cell setDataWithModel:self.arrayData[indexPath.row]];
    return cell;
}

@end
