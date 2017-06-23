//
//  BTPlazaVC.m
//  BanTang
//
//  Created by guanli on 16/3/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPlazaVC.h"
#import "BTPlazaBannerCell.h"
#import "BTPlazaCategoryCell.h"
#import "BTPlazaRecommendCell.h"
#import "BTPlazaHeadReusableView.h"
#import "BTPlazaLeftListView.h"

#import "BTPlazaNetWorkRequest.h"
#import "BTPlazaModal.h"
#import "BTPlazaBannerModal.h"
#import "BTPlazaCategoryModal.h"
#import "BTPlazaRecommendModal.h"

#import "BTCategoryVC.h"
#import "BTHotRecommendVC.h"
#import "BTPlazaGrassController.h"

#define BannerHeight ScreenWidth*(8.0/16)

@interface BTPlazaVC () <
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
BTPlazaHomePageBannerCellSelected,
BTPlazaHomePageCategoryCellSelected,
BTPlazaLeftListViewDelegate
> {
    
    NSInteger _currentPage;
    BOOL _leftListViewShow;
    
}

@property (nonatomic, retain)UICollectionView *collV;
@property (nonatomic, retain)NSMutableArray *bannerImageUrlArray;//banner图片数组
@property (nonatomic, retain)NSMutableArray *bannerModalArray;//banner模型数组
@property (nonatomic, retain)NSMutableArray *categoryModalArray;//分类模型数组;
@property (nonatomic, retain)NSMutableArray *recommendModalArray;//热门推荐模型数组
@property (nonatomic, retain)UIView *navBarView;
@property (nonatomic, retain)BTPlazaLeftListView *leftListView;

@end

@implementation BTPlazaVC

#pragma mark - Lazy

- (NSMutableArray *)bannerImageUrlArray {
    if (!_bannerImageUrlArray) {
        _bannerImageUrlArray = [[NSMutableArray alloc]init];
    }
    return _bannerImageUrlArray;
}

- (NSMutableArray *)bannerModalArray {
    if (!_bannerModalArray) {
        _bannerModalArray = [[NSMutableArray alloc]init];
    }
    return _bannerModalArray;
}

- (NSMutableArray *)categoryModalArray {
    if (!_categoryModalArray) {
        _categoryModalArray = [[NSMutableArray alloc]init];
    }
    return _categoryModalArray;
}

- (NSMutableArray *)recommendModalArray {
    if (!_recommendModalArray) {
        _recommendModalArray = [[NSMutableArray alloc]init];
    }
    return _recommendModalArray;
}

#pragma mark - SetUpUI

- (BTPlazaLeftListView *)leftListView {
    if (!_leftListView) {
        NSArray *menus = @[@"我得关注",@"种草小分队"];
        _leftListView = [[BTPlazaLeftListView alloc] initWithBounds:CGRectMake(0, 0, 130, 40*2) titleMenus:menus];
        _leftListView.delegate = self;
        _leftListView.containerBackgroudColor = [UIColor whiteColor];
        
    }
    return _leftListView;
}

- (UIView *)navBarView {
    if (!_navBarView) {
        _navBarView = [[UIView alloc]init];
        _navBarView.backgroundColor = TopicColor;
        _navBarView.frame = CGRectMake(0, 0, ScreenWidth, 63);
        
        UILabel *labTitle = [[UILabel alloc]init];
        labTitle.textColor = [UIColor whiteColor];
        labTitle.font = [UIFont systemFontOfSize:17];
        labTitle.text = @"发现";
        [_navBarView addSubview:labTitle];
        [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_navBarView).offset(10);
            make.centerX.equalTo(_navBarView);
        }];
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //leftBtn.backgroundColor = ItemBackgroundColor;
        [leftBtn setImage:[UIImage imageNamed:@"discovey_pop_btn_20x20_"] forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"discovey_pop_dark_btn_20x20_"] forState:UIControlStateHighlighted];
        [leftBtn addTarget:self action:@selector(onLeftBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navBarView addSubview:leftBtn];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_navBarView).offset(10);
            make.left.equalTo(@10);
            make.height.width.equalTo(@30);
        }];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //rightBtn.backgroundColor = ItemBackgroundColor;
        [rightBtn setImage:[UIImage imageNamed:@"discover_write_article_dark_icon_19x20_"] forState:UIControlStateNormal];
        [rightBtn setImage:[UIImage imageNamed:@"discover_write_article_icon_19x20_"] forState:UIControlStateHighlighted];
        [rightBtn addTarget:self action:@selector(onRightWriteBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navBarView addSubview:rightBtn];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_navBarView).offset(10);
            make.right.equalTo(@(-10));
            make.height.width.equalTo(@30);
        }];
        
        UIImageView *navBarShadow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63, ScreenWidth, 1)];
        UIImage *image = [UIImage imageNamed:@"navigation_bar_shadow"];
        navBarShadow.image = image;
        [self.view addSubview:navBarShadow];
    }
    return _navBarView;
}

- (UICollectionView *)collV {
    if (!_collV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-NavBarHeight-TabBarHeight) collectionViewLayout:layout];
        _collV.backgroundColor = BackgroundColor;
        
        [_collV registerClass:[BTPlazaBannerCell class] forCellWithReuseIdentifier:NSStringFromClass([BTPlazaBannerCell class])];
        [_collV registerClass:[BTPlazaCategoryCell class] forCellWithReuseIdentifier:NSStringFromClass([BTPlazaCategoryCell class])];
        [_collV registerClass:[BTPlazaRecommendCell class] forCellWithReuseIdentifier:NSStringFromClass([BTPlazaRecommendCell class])];
        [_collV registerClass:[BTPlazaHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([BTPlazaHeadReusableView class])];
        
        _collV.delegate = self;
        _collV.dataSource = self;
    }
    return _collV;
}

#pragma mark - ViewLifeCycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationItem.title = @"发现";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navBarView];
    [self.view addSubview:self.collV];
    
    //获取banner和分类网络数据
    [self getBannerDataAndCategoryData];
    //设置当前热门推荐的页数默认为0;
    _currentPage = 0;
    [self getHostRecommendDataWithFirstStart:YES];
    
    //配置刷新与加载
    [self setUpRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SetUpRefresh

- (void)setUpRefresh {
    BTDIYHeader *header = [BTDIYHeader headerWithRefreshingBlock:^{
        [self getBannerDataAndCategoryData];
        [self getHostRecommendDataWithFirstStart:YES];
     }];
    self.collV.mj_header = header;
    
    BTDIYFooter *footer = [BTDIYFooter footerWithRefreshingBlock:^{
        [self getHostRecommendDataWithFirstStart:NO];
    }];
    self.collV.mj_footer = footer;
}

#pragma mark - NetWorkRequest

//banner和分类网络数据请求
- (void)getBannerDataAndCategoryData {
    BTURLParameterManager *parameterDic = [BTURLParameterManager sharedInstance];
    [parameterDic setObject:[NSDate unixDateString] forKey:@"app_installtime"];
    [[BTPlazaNetWorkRequest sharedInstance] getPlazaBannerDataAndCategoryDataWithDictionary:parameterDic success:^(id obj) {
        BTPlazaModal *plazaModal = obj;
        //添加banner模型数据源
        [self.bannerModalArray removeAllObjects];
        [self.bannerModalArray addObjectsFromArray:plazaModal.banner];
        //添加分类模型数据源
        [self.categoryModalArray removeAllObjects];
        [self.categoryModalArray addObjectsFromArray:plazaModal.category_list];
        
        //添加banner图片URL
        [self.bannerImageUrlArray removeAllObjects];
        for (BTPlazaBannerModal *bannerModal in self.bannerModalArray) {
            [self.bannerImageUrlArray addObject:bannerModal.photo];
        }

        [self.collV reloadData];
        
        //更改刷新状态
        [self.collV.mj_header endRefreshing];
        self.collV.mj_footer.state = MJRefreshStateIdle;
    } failure:^(id obj) {
        
    }];
}

- (void)getHostRecommendDataWithFirstStart:(BOOL)firstStart {
    if (firstStart) {
        //第一次加载数据
        _currentPage = 0;
    } else {
        _currentPage ++;
    }
    NSLog(@"热门推荐当前页数:%@",[NSString stringWithFormat:@"%ld",(long)_currentPage]);
    BTURLParameterManager *parameterDic = [BTURLParameterManager sharedInstance];
    [parameterDic setObject:[NSDate unixDateString] forKey:@"app_installtime"];
    [parameterDic setObject:[NSString stringWithFormat:@"%ld",(long)_currentPage] forKey:@"page"];
    [parameterDic setObject:@"18" forKey:@"pagesize"];
    [[BTPlazaNetWorkRequest sharedInstance] getPlazaRecommendDataWithDictionary:parameterDic success:^(id obj) {
        //添加热门推荐模型数组
        if (firstStart) {
            //每次第一次加载数据,都要清空数组
            [self.recommendModalArray removeAllObjects];
        }
        [self.recommendModalArray addObjectsFromArray:obj];
        NSLog(@"热门推荐数组个数:%d",self.recommendModalArray.count);
        [self.collV reloadData];
        
        //更改刷新状态
        if (self.recommendModalArray.count%18 == 0) {
            //每次都返回18组数据
            [self.collV.mj_footer endRefreshing];
        } else {
            [self.collV.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(id obj) {
        
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        //banner区
        if (self.bannerModalArray.count == 0) {
            return 0;
        } else {
            return 1;
        }
    } else if (section == 1) {
        //分类区
        if (self.categoryModalArray.count == 0) {
            return 0;
        } else {
            return 1;
        }
    } else {
        //热门推荐区
        return self.recommendModalArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //banner区
        BTPlazaBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BTPlazaBannerCell class]) forIndexPath:indexPath];
        cell.scrollView.imageURLStringsGroup = self.bannerImageUrlArray;
        cell.delegate = self;
        return cell;
    } else if (indexPath.section == 1) {
        //分类区
        BTPlazaCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BTPlazaCategoryCell class]) forIndexPath:indexPath];
        [cell setCellInfoWithArray:self.categoryModalArray];
        cell.delegate = self;
        return cell;
    } else {
        //热门推荐区
        BTPlazaRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BTPlazaRecommendCell class]) forIndexPath:indexPath];
        BTPlazaRecommendModal *recommendModal = [self.recommendModalArray validObjectForIndex:indexPath.item];
        [cell setCellInfoWithModal:recommendModal];
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //banner区
        return CGSizeMake(ScreenWidth, BannerHeight);
    } else if (indexPath.section == 1) {
        //分类区
        return [collectionView ar_sizeForCellWithIdentifier:NSStringFromClass([BTPlazaCategoryCell class]) indexPath:indexPath fixedWidth:ScreenWidth configuration:^(__kindof BTPlazaCategoryCell *cell) {
            [cell setCellInfoWithArray:self.categoryModalArray];
        }];
    } else {
        //热门推荐
        return CGSizeMake((ScreenWidth - 3.0*2)/3.0, (ScreenWidth - 5.0*2)/3.0);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
        return UIEdgeInsetsMake(0, 0, 10, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 2) {
        return 3.0;
    }
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && kind == UICollectionElementKindSectionHeader) {
        //分类区
        if (self.categoryModalArray.count != 0) {
            //分类区
            BTPlazaHeadReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([BTPlazaHeadReusableView class]) forIndexPath:indexPath];
            reusableView.imgV.image = [UIImage imageNamed:@"descover_categoty_icon_12x12_"];
            reusableView.labTitle.text = @"分类";
            return reusableView;
        }
        
    } else if (indexPath.section == 2 && kind == UICollectionElementKindSectionHeader) {
        //分类区
        if (self.recommendModalArray.count != 0) {
            BTPlazaHeadReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([BTPlazaHeadReusableView class]) forIndexPath:indexPath];
            reusableView.imgV.image = [UIImage imageNamed:@"descover_hot_icon_10x12_"];
            reusableView.labTitle.text = @"热门推荐";
            
            return reusableView;
        }
        
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        if (self.categoryModalArray.count != 0) {
            return CGSizeMake(ScreenWidth, 49);
        }
    } else if (section == 2) {
        if (self.recommendModalArray.count != 0) {
            return CGSizeMake(ScreenWidth, 49);
        }
    }
    return CGSizeMake(0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        //NSLog(@"%@",indexPath);
        BTHotRecommendVC *hotRecommendVC = [[BTHotRecommendVC alloc] init];
        hotRecommendVC.indexPath_Item = indexPath.item;
        hotRecommendVC.hotRecommendModalArray = self.recommendModalArray;
        hotRecommendVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hotRecommendVC animated:YES];
    }
}

#pragma mark - Clicked_Event

//banner点击
- (void)onHomePageBannerCellSelectedWithIndex:(NSInteger)index {
    BTPlazaBannerModal *bannerModal = [self.bannerModalArray validObjectForIndex:index];
    NSLog(@"%@",bannerModal);
}

//分类点击
- (void)onHomePageCategoryCellSelectedWithIndex:(NSInteger)index {
    BTPlazaCategoryModal *plazaCategoryModal = [self.categoryModalArray validObjectForIndex:index];
    NSLog(@"分类点击:%d  %@",index,plazaCategoryModal.id_);
    BTCategoryVC *categoryVC = [[BTCategoryVC alloc]init];
    categoryVC.plazaCategoryModal = plazaCategoryModal;
    categoryVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:categoryVC animated:YES];
}

- (void)onLeftBarButtonClick:(UIButton *)sender {
    
    if (_leftListViewShow == NO) {
        [self.view addSubview:self.leftListView];
       [self.leftListView showFrom:sender alignStyle:ListViewAlignStyleLeft];
    } else {
        [self.leftListView dismiss];
    }
}

- (void)onRightWriteBarButtonClick:(UIButton *)sender {
    if (_leftListViewShow == YES) {
        [self.leftListView dismiss];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_leftListViewShow == YES) {
        [self.leftListView dismiss];
    }
}

#pragma mark - BTPlazaLeftListViewDelegate

- (void)listViewDidShow:(BTPlazaLeftListView *)pView {
    _leftListViewShow = YES;
}

- (void)listViewDidDismiss:(BTPlazaLeftListView *)pView {
    _leftListViewShow = NO;
}

- (void)showListView:(BTPlazaLeftListView *)listView didClickAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
        
            break;
        case 1:
        {
            BTPlazaGrassController *grassVC = [[BTPlazaGrassController alloc] init];
            grassVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:grassVC animated:YES];
            
            [self.leftListView dismiss];
        }
            break;
        default:
            break;
    }
}

@end







