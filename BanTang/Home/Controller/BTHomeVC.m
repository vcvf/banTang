//
//  BTHomeVC.m
//  BanTang
//
//  Created by guanli on 16/3/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTHomeVC.h"
#import "BTHomeMainScrollView.h"
#import "BTHomeBannerView.h"
#import "BTHomeCategoryScrollView.h"
#import "BtHomeCollectionViewCell.h"
#import "BTHomeTopicTableViewCell.h"

#import "BTHomeNetWorkRequest.h"//网络请求
#import "BTHomeModal.h"
#import "BTHomeBannerModal.h"

#define BannerHeight ScreenWidth*(8.0/16)

@interface BTHomeVC () <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BTHomeCategoryScrollViewDelegate,UITableViewDelegate>
{
    //CGFloat tableViewOffsetY;
}

@property (nonatomic, retain)BTHomeMainScrollView *mainScrollView;
@property (nonatomic, retain)UIView *navBarView;
@property (nonatomic, retain)UIView *contentView;
@property (nonatomic, retain)BTHomeBannerView *bannerView;
@property (nonatomic, retain)BTHomeCategoryScrollView *categoryScrollV;//分类滑动条
@property (nonatomic, retain)UICollectionView *mainCollV;

@property (nonatomic, assign)BOOL mainScrollViewEnabled;
@property (nonatomic, assign)BOOL tableViewScrollEnabled;
@property (nonatomic, assign)BOOL isTopIsCanNotMoveTableView;
@property (nonatomic, assign)BOOL isTopIsCanNotMoveTableViewPrePare;

@property (nonatomic, retain)NSMutableArray *bannerArray;//广告轮播数组
@property (nonatomic, retain)NSMutableArray *categoryArray;//分类条内容数组
@property (nonatomic, retain)NSMutableArray *topicArray;//最新商品数组

@end

@implementation BTHomeVC

#pragma mark - lazy

- (NSMutableArray *)topicArray {
    if (!_topicArray) {
        _topicArray = [[NSMutableArray alloc]init];
    }
    return _topicArray;
}

- (NSMutableArray *)categoryArray {
    if (!_categoryArray) {
        _categoryArray = [[NSMutableArray alloc]init];
    }
    return _categoryArray;
}

- (NSMutableArray *)bannerArray {
    if (!_bannerArray) {
        _bannerArray = [[NSMutableArray alloc]init];
    }
    return _bannerArray;
}

- (UIView *)navBarView {
    if (!_navBarView) {
        _navBarView = [[UIView alloc]init];
        _navBarView.backgroundColor = [TopicColor colorWithAlphaComponent:0];
        _navBarView.frame = CGRectMake(0, 0, ScreenWidth, 63);
        
        UIImageView *navBarShadow = [[UIImageView alloc]initWithFrame:CGRectMake(0, 63, ScreenWidth, 1)];
        navBarShadow.alpha = 0;
        UIImage *image = [UIImage imageNamed:@"navigation_bar_shadow"];
        navBarShadow.image = image;
        [_navBarView addSubview:navBarShadow];
    }
    return _navBarView;
}

- (BTHomeBannerView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[BTHomeBannerView alloc]init];
    }
    return _bannerView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (BTHomeMainScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[BTHomeMainScrollView alloc]init];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.backgroundColor = [UIColor redColor];
        _mainScrollView.delegate = self;
    }
    return _mainScrollView;
}

- (BTHomeCategoryScrollView *)categoryScrollV {
    if (!_categoryScrollV) {
        _categoryScrollV = [[BTHomeCategoryScrollView alloc]init];
        _categoryScrollV.frame = CGRectMake(0, BannerHeight, ScreenWidth, 45);
        _categoryScrollV.categoryDelegate = self;
    }
    return _categoryScrollV;
}

- (UICollectionView *)mainCollV {
    if (!_mainCollV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsZero;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _mainCollV = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _mainCollV.backgroundColor = [UIColor whiteColor];
        _mainCollV.pagingEnabled = YES;
        _mainCollV.bounces = NO;
        
        [_mainCollV registerClass:[BtHomeCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([BtHomeCollectionViewCell class])];
        
        _mainCollV.dataSource = self;
        _mainCollV.delegate = self;
    }
    return _mainCollV;
}

#pragma mark - SetUpUI

- (void)buildMainScrollView {
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.contentView];
    [self.view addSubview:self.categoryScrollV];
    [self.view addSubview:self.navBarView];
    
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-TabBarHeight);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainScrollView);
        make.width.equalTo(self.mainScrollView);
    }];
}

- (void)buildContentView {
    [self.contentView addSubview:self.bannerView];
    [self.contentView addSubview:self.mainCollV];
    
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(self.contentView);
        make.height.equalTo(@(BannerHeight + 45));
    }];
    
    [self.mainCollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(ScreenHeight - NavBarHeight - 45 - TabBarHeight);
    }];
    
}

- (void)setUpUI {
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self buildMainScrollView];
    [self buildContentView];
}

#pragma mark - ViewLifeCycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    //首页最新页面网络请求
    BTURLParameterManager *parameterDic = [BTURLParameterManager sharedInstance];
    [parameterDic setObject:[NSDate unixDateString] forKey:@"app_installtime"];
    [parameterDic setObject:@"0" forKey:@"page"];
    [parameterDic setObject:@"20" forKey:@"pagesize"];
    [[BTHomeNetWorkRequest sharedInstance] getHomeRecommendDataWithDictionary:parameterDic success:^(id obj) {
        BTHomeModal *homeModal = obj;
        //添加banner数据源
        [self.bannerArray addObjectsFromArray:homeModal.banner];
        //添加分类栏数据源
        [self.categoryArray addObjectsFromArray:homeModal.category_element];
        self.categoryScrollV.arrayTitle = self.categoryArray;
        //添加最新商品列表
        [self.topicArray addObjectsFromArray:homeModal.topic];
        
        //刷新Banner信息
        [self.bannerView setBannerInfoWithArray:self.bannerArray];
        //刷新表
        [self.mainCollV reloadData];
    } failure:^(id obj) {
        NSLog(@"%@",obj);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"释放了");
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categoryArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BtHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BtHomeCollectionViewCell class]) forIndexPath:indexPath];
    cell.topicArray = self.topicArray;
    cell.tableV.delegate = self;
    self.currentTableView = cell.tableV;
    return cell;
}

#pragma mark - UICollectionViewDelegate



#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.mainCollV.bounds.size;
}

#pragma mark - UITableViewDelegate 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([BTHomeTopicTableViewCell class]) cacheByIndexPath:indexPath configuration:^(id cell) {
        [cell setCellInfoWithModal:[self.topicArray validObjectForIndex:indexPath.row]];
    }];
}

#pragma mark - UIScrollViewDelegate 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        self.mainScrollView.scrollEnabled = NO;
    }
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        if (!self.tableViewScrollEnabled) {
            [scrollView setContentOffset:CGPointZero];
        }
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY < 0) {
            self.mainScrollViewEnabled = YES;
            self.tableViewScrollEnabled = NO;
            [scrollView setContentOffset:CGPointZero];
        }
    }
    
    if ([scrollView isEqual:self.mainScrollView]) {
        //分类条悬停
        if (scrollView.contentOffset.y >= BannerHeight - NavBarHeight) {
            self.categoryScrollV.frame = CGRectMake(0, NavBarHeight, ScreenWidth, 45);
        } else {
            self.categoryScrollV.frame = CGRectMake(0, BannerHeight-scrollView.contentOffset.y, ScreenWidth, 45);
        }
        
        //导航条颜色渐变
        CGFloat alpha = scrollView.contentOffset.y / (BannerHeight - NavBarHeight);
        for (UIView *subView in self.navBarView.subviews) {
            subView.alpha = alpha;
        }
        self.navBarView.backgroundColor = [TopicColor colorWithAlphaComponent:alpha];
        
    }
    
    self.mainScrollView.scrollEnabled = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        NSInteger index = scrollView.contentOffset.x / ScreenWidth;
        [self.categoryScrollV categoryScrollViewScrollToIndex:index];
    }
}

#pragma mark Click_Event

- (void)onBTHomeCategoryScrollViewClicked:(BTHomeCategoryScrollView *)categoryScrollView atIndex:(NSInteger)index {
    [self.mainCollV setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:YES];
}

@end












