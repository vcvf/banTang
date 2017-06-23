//
//  BTPlazaGrassController.m
//  BanTang
//
//  Created by guanli on 16/5/6.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPlazaGrassController.h"
#import "BTPlazaGrassCell.h"
#import "BTPlazaGrassReusableView.h"

#import "BTPlazaNetWorkRequest.h"
#import "BTPlazaGrassModal.h"

@interface BTPlazaGrassController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    BOOL _isFistPage;
}

@property (nonatomic, retain)UIView *navBarView;
@property (nonatomic, retain)UICollectionView *collV;
@property (nonatomic, retain)NSMutableArray *grassModalArrayOne;
@property (nonatomic, retain)NSMutableArray *grassModalArrayTwo;

@end

@implementation BTPlazaGrassController

#pragma mark - Lazy

- (NSMutableArray *)grassModalArrayOne {
    if (!_grassModalArrayOne) {
        _grassModalArrayOne = [[NSMutableArray alloc]init];
    }
    return _grassModalArrayOne;
}

- (NSMutableArray *)grassModalArrayTwo {
    if (!_grassModalArrayTwo) {
        _grassModalArrayTwo = [[NSMutableArray alloc]init];
    }
    return _grassModalArrayTwo;
}

#pragma mark - SetUpUI

- (UICollectionView *)collV {
    if (!_collV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        _collV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NavBarHeight, ScreenWidth, ScreenHeight-NavBarHeight) collectionViewLayout:layout];
        _collV.backgroundColor = BackgroundColor;
        _collV.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
        
        [_collV registerClass:[BTPlazaGrassReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([BTPlazaGrassReusableView class])];
        [_collV registerClass:[BTPlazaGrassReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([BTPlazaGrassReusableView class])];
        [_collV registerClass:[BTPlazaGrassCell class] forCellWithReuseIdentifier:NSStringFromClass([BTPlazaGrassCell class])];
        
        _collV.delegate = self;
        _collV.dataSource = self;
    }
    return _collV;
}

- (UIView *)navBarView {
    if (!_navBarView) {
        _navBarView = [[UIView alloc]init];
        _navBarView.backgroundColor = TopicColor;
        _navBarView.frame = CGRectMake(0, 0, ScreenWidth, 63);
        
        UILabel *labTitle = [[UILabel alloc]init];
        labTitle.textColor = [UIColor whiteColor];
        labTitle.font = [UIFont systemFontOfSize:17];
        labTitle.text = @"种草小分队";
        [_navBarView addSubview:labTitle];
        [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_navBarView).offset(10);
            make.centerX.equalTo(_navBarView);
        }];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //leftBtn.backgroundColor = ItemBackgroundColor;
        [leftBtn setImage:[UIImage imageNamed:@"tb_icon_navigation_back"] forState:UIControlStateNormal];
        //[leftBtn setImage:[UIImage imageNamed:@"discovey_pop_dark_btn_20x20_"] forState:UIControlStateHighlighted];
        [leftBtn addTarget:self action:@selector(onLeftBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navBarView addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_navBarView).offset(10);
            make.left.equalTo(@10);
            make.height.width.equalTo(@30);
        }];
        
        UIImageView *navBarShadow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63, ScreenWidth, 1)];
        UIImage *image = [UIImage imageNamed:@"navigation_bar_shadow"];
        navBarShadow.image = image;
        [self.view addSubview:navBarShadow];
    }
    return _navBarView;
}

- (void)setUpUI {
    [self.view addSubview:self.navBarView];
    [self.view addSubview:self.collV];
}

#pragma mark - ViewLifeCycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = BackgroundColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isFistPage = YES;
    [self setUpUI];
    [self getGrassListData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark  - SetUpRefresh

#pragma mark - NetWorkRequest

/**获取种草小分队列表数据*/
- (void)getGrassListData {
    BTURLParameterManager *parameterDic = [BTURLParameterManager sharedInstance];
    [parameterDic setObject:[NSDate unixDateString] forKey:@"app_installtime"];
    [[BTPlazaNetWorkRequest sharedInstance] getGrassListDataWithDictionary:parameterDic success:^(id obj) {
        NSMutableArray *modalArray = obj;
        for (int i = 0; i < modalArray.count; i ++) {
            if (i < 5) {
                [self.grassModalArrayOne addObject:[modalArray validObjectForIndex:i]];
            } else {
                [self.grassModalArrayTwo addObject:[modalArray validObjectForIndex:i]];
            }
        }
        [self.collV reloadData];
    } failure:^(id obj) {
        
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_isFistPage == YES) {
        return self.grassModalArrayOne.count;
    } else {
        return self.grassModalArrayTwo.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BTPlazaGrassCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BTPlazaGrassCell class]) forIndexPath:indexPath];
    if (_isFistPage == YES) {
        BTPlazaGrassModal *grassModal = [self.grassModalArrayOne validObjectForIndex:indexPath.item];
        [cell setCellInfoWithModal:grassModal];
    } else {
        BTPlazaGrassModal *grassModal = [self.grassModalArrayTwo validObjectForIndex:indexPath.item];
        [cell setCellInfoWithModal:grassModal];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && kind == UICollectionElementKindSectionHeader) {
        BTPlazaGrassReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([BTPlazaGrassReusableView class]) forIndexPath:indexPath];
        [headView.btnChange setTitle:@"种草小分队" forState:UIControlStateNormal];
        return headView;
    } else if (indexPath.section == 0 && kind == UICollectionElementKindSectionFooter) {
        BTPlazaGrassReusableView *footView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([BTPlazaGrassReusableView class]) forIndexPath:indexPath];
        UIImage *image = [[UIImage imageNamed:@"commu_home_recom_change_icon_70x14_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [footView.btnChange setImage:image forState:UIControlStateNormal];
        [footView.btnChange setImage:image forState:UIControlStateHighlighted];
        [footView.btnChange addTarget:self action:@selector(onChangeListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        return footView;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView ar_sizeForCellWithIdentifier:NSStringFromClass([BTPlazaGrassCell class]) indexPath:indexPath fixedWidth:ScreenWidth configuration:^(__kindof BTPlazaGrassCell *cell) {
        if (_isFistPage == YES) {
            BTPlazaGrassModal *grassModal = [self.grassModalArrayOne validObjectForIndex:indexPath.item];
            [cell setCellInfoWithModal:grassModal];
        } else {
            BTPlazaGrassModal *grassModal = [self.grassModalArrayTwo validObjectForIndex:indexPath.item];
            [cell setCellInfoWithModal:grassModal];
        }
    }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, 40);
}

#pragma mark - Click_Event


- (void)onLeftBarButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onChangeListBtnClick:(UIButton *)sender {
    _isFistPage = !_isFistPage;
    [self.collV reloadData];
}

@end
