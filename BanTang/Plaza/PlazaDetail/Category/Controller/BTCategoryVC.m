//
//  BTCategoryVC.m
//  BanTang
//
//  Created by guanli on 16/4/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTCategoryVC.h"
#import "BTCategoryHeadReusableView.h"
#import "BTCategoryListSmallCell.h"
#import "BTCategoryListBigCell.h"
#import "BTGoodsDetailVC.h"

#import "BTPlazaNetWorkRequest.h"
#import "BTCategorySubclassModal.h"

#define ImgVSmallHeight (ScreenWidth - 10*3)/2.0

@interface BTCategoryVC () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BTCategoryListBigCellDelegate> {
    UIButton *_selectedBtn;
    NSInteger _type_id;//为1时是精选 为0时是全部
    NSInteger _goodListCurrentPageNum;//精选页面的页数
    NSInteger _allListCurrenPageNum;//全部页面的页数
    
    BOOL _isBig;//是否为大视图
}

@property (nonatomic, retain)UICollectionView *collV;
@property (nonatomic, retain)UIView *navBarView;
/**头部列表数据*/
@property (nonatomic, retain)NSMutableArray *categorySubClassModalArray;
/**精选列表数据*/
@property (nonatomic, retain)NSMutableArray *goodListModalArray;
/**全部列表数据*/
@property (nonatomic, retain)NSMutableArray *allListModalArray;


@end

@implementation BTCategoryVC

#pragma mark - Lazy

- (NSMutableArray *)allListModalArray {
    if (!_allListModalArray) {
        _allListModalArray = [[NSMutableArray alloc]init];
    }
    return _allListModalArray;
}

- (NSMutableArray *)goodListModalArray {
    if (!_goodListModalArray) {
        _goodListModalArray = [[NSMutableArray alloc]init];
    }
    return _goodListModalArray;
}

- (NSMutableArray *)categorySubClassModalArray {
    if (!_categorySubClassModalArray) {
        _categorySubClassModalArray = [[NSMutableArray alloc]init];
    }
    return _categorySubClassModalArray;
}

#pragma mark - SetUpUI

- (UIView *)navBarView {
    if (!_navBarView) {
        _navBarView = [[UIView alloc]init];
        _navBarView.backgroundColor = TopicColor;
        _navBarView.frame = CGRectMake(0, 0, ScreenWidth, 63);
        
        UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftItem setImage:[UIImage imageNamed:@"tb_icon_navigation_back"] forState:UIControlStateNormal];
        [leftItem addTarget:self action:@selector(onLeftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_navBarView addSubview:leftItem];
        [leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_navBarView).offset(10);
            make.left.equalTo(_navBarView).offset(5);
            make.width.height.equalTo(@30);
        }];
        
        UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
        //rightItem.backgroundColor = ItemBackgroundColor;
        [rightItem setImage:[UIImage imageNamed:@"btn_group_switch_list_24x20_"] forState:UIControlStateNormal];
        [rightItem addTarget:self action:@selector(onRightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_navBarView addSubview:rightItem];
        [rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_navBarView).offset(10);
            make.right.equalTo(_navBarView).offset(-5);
            make.width.height.equalTo(@30);
        }];
        
        UIView *viewLine = [[UIView alloc] init];
        viewLine.backgroundColor = ItemBackgroundColor;
        [_navBarView addSubview:viewLine];
        [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_navBarView);
            make.centerY.equalTo(_navBarView).offset(10);
            make.height.equalTo(@13);
            make.width.equalTo(@1);
        }];
        
        UIButton *allTypeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        allTypeBtn.titleLabel.font = [UIFont  systemFontOfSize:15];
        [allTypeBtn setTitle:@"全部" forState:UIControlStateNormal];
        [allTypeBtn setTitleColor:ItemBackgroundColor forState:UIControlStateNormal];
        [allTypeBtn addTarget:self action:@selector(onChangeTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        allTypeBtn.tag = 1;
        [_navBarView addSubview:allTypeBtn];
        [allTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_navBarView).offset(10);
            make.right.equalTo(viewLine.mas_left).offset(-18);
            make.left.greaterThanOrEqualTo(_navBarView);
        }];
        
        UIButton *goodTypeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        goodTypeBtn.titleLabel.font = [UIFont  systemFontOfSize:17];
        [goodTypeBtn setTitle:@"精选" forState:UIControlStateNormal];
        [goodTypeBtn setTitleColor:TitleDarkColor forState:UIControlStateNormal];
        [goodTypeBtn addTarget:self action:@selector(onChangeTypeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        goodTypeBtn.tag = 2;
        _selectedBtn = goodTypeBtn;
        [_navBarView addSubview:goodTypeBtn];
        [goodTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_navBarView).offset(10);
            make.left.equalTo(viewLine.mas_right).offset(18);
            make.right.lessThanOrEqualTo(_navBarView);
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
        _collV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) collectionViewLayout:layout];
        _collV.backgroundColor = BackgroundColor;
        
        [_collV registerClass:[BTCategoryHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([BTCategoryHeadReusableView class])];
        [_collV registerClass:[BTCategoryListSmallCell class] forCellWithReuseIdentifier:NSStringFromClass([BTCategoryListSmallCell class])];
        [_collV registerClass:[BTCategoryListBigCell class] forCellWithReuseIdentifier:NSStringFromClass([BTCategoryListBigCell class])];
        
        _collV.delegate = self;
        _collV.dataSource = self;
    }
    return _collV;
}

- (void)setUpUI {
    [self.view addSubview:self.collV];
    [self.view addSubview:self.navBarView];
}

#pragma mark - ViewLifeCycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = BackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化类型
    _isBig = NO;//小图
    _type_id = 1;
    _goodListCurrentPageNum = 0;
    _allListCurrenPageNum = 0;
    
    /**设置UI*/
    [self setUpUI];
    /**获取头部列表数据*/
    [self getCategorySubClassListWithRestart:YES];
    /**根据分类获取精选列表*/
    [self getGoodListDataByCategoryWithRestart:YES withType:1];
    /**根据分类获取全部列表*/
    [self getAllListDataByCategoryWithRestart:YES withType:0];
    /**配置刷新列表*/
    [self setUpRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SetUpRefresh

- (void)setUpRefresh {
    BTDIYHeader *header = [BTDIYHeader headerWithRefreshingBlock:^{
        if (_type_id == 1) {
            _goodListCurrentPageNum = 0;
            [self getGoodListDataByCategoryWithRestart:YES withType:_type_id];
        } else {
            _allListCurrenPageNum = 0;
            [self getAllListDataByCategoryWithRestart:YES withType:_type_id];
        }
        [self getCategorySubClassListWithRestart:YES];
    }];
    self.collV.mj_header = header;
    
    BTDIYFooter *footer = [BTDIYFooter footerWithRefreshingBlock:^{
        if (_type_id == 1) {
            _goodListCurrentPageNum ++;
            [self getGoodListDataByCategoryWithRestart:NO withType:_type_id];
        } else {
            _allListCurrenPageNum ++;
            [self getAllListDataByCategoryWithRestart:NO withType:_type_id];
        }
        //[self getCategorySubClassListWithRestart:NO];
    }];
    footer.triggerAutomaticallyRefreshPercent = 1.0;
    self.collV.mj_footer = footer;
}

#pragma mark - NetWorkRequest

/**获取头部列表数据*/
- (void)getCategorySubClassListWithRestart:(BOOL)isRestart {
    BTURLParameterManager *parameterDic = [BTURLParameterManager sharedInstance];
    [parameterDic setObject:[NSDate unixDateString] forKey:@"app_installtime"];
    [parameterDic setObject:self.plazaCategoryModal.id_ forKey:@"id"];
    [[BTPlazaNetWorkRequest sharedInstance] getCategoryDetailSubClassDataWithDictionary:parameterDic success:^(id obj) {
        [self.categorySubClassModalArray removeAllObjects];
        /**给头部列表模型赋值*/
        if (isRestart) {
            [self.categorySubClassModalArray removeAllObjects];
        }
        [self.categorySubClassModalArray addObjectsFromArray:obj];
        //刷新表
        [self.collV reloadData];
        //更改刷新状态
        [self.collV.mj_header endRefreshing];
        self.collV.mj_footer.state = MJRefreshStateIdle;
    } failure:^(id obj) {
        
    }];
}

/**根据分类获取精选列表*/
- (void)getGoodListDataByCategoryWithRestart:(BOOL)isRestart withType:(NSInteger)type{
    BTURLParameterManager *parameterDic = [BTURLParameterManager sharedInstance];
    [parameterDic setObject:[NSDate unixDateString] forKey:@"app_installtime"];
    [parameterDic setObject:self.plazaCategoryModal.id_ forKey:@"id"];
    [parameterDic setObject:[NSString stringWithFormat:@"%ld",(long)_goodListCurrentPageNum] forKey:@"page"];
    [parameterDic setObject:@"10" forKey:@"pagesize"];
    [parameterDic setObject:[NSString stringWithFormat:@"%ld",(long)type] forKey:@"type_id"];
    [[BTPlazaNetWorkRequest sharedInstance] getListDataByCategoryWithDictionary:parameterDic success:^(id obj) {
            //精选
            /**给精选列表数组赋值*/
            if (isRestart) {
                [self.goodListModalArray removeAllObjects];
            }
            [self.goodListModalArray addObjectsFromArray:obj];
            //刷新表
            [self.collV reloadData];
            //更改刷新状态
            if (self.goodListModalArray.count % 10 == 0) {
                [self.collV.mj_footer endRefreshing];
            } else {
                [self.collV.mj_footer endRefreshingWithNoMoreData];
            }
    } failure:^(id obj) {
        
    }];
}

/**根据分类获取全部列表*/
- (void)getAllListDataByCategoryWithRestart:(BOOL)isRestart withType:(NSInteger)type{
    BTURLParameterManager *parameterDic = [BTURLParameterManager sharedInstance];
    [parameterDic setObject:[NSDate unixDateString] forKey:@"app_installtime"];
    [parameterDic setObject:self.plazaCategoryModal.id_ forKey:@"id"];
    [parameterDic setObject:[NSString stringWithFormat:@"%ld",(long)_allListCurrenPageNum] forKey:@"page"];
    [parameterDic setObject:@"10" forKey:@"pagesize"];
    [parameterDic setObject:[NSString stringWithFormat:@"%ld",(long)type] forKey:@"type_id"];
    [[BTPlazaNetWorkRequest sharedInstance] getListDataByCategoryWithDictionary:parameterDic success:^(id obj) {
        /**给全部列表数组赋值*/
        if (isRestart) {
            [self.allListModalArray removeAllObjects];
        }
        [self.allListModalArray addObjectsFromArray:obj];
        //刷新表
        [self.collV reloadData];
        //更改刷新状态
        if (self.allListModalArray.count % 10 == 0) {
            [self.collV.mj_footer endRefreshing];
        } else {
            [self.collV.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(id obj) {
        
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_type_id == 1) {
        return self.goodListModalArray.count;
    } else {
        return self.allListModalArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_isBig == NO) {
        BTCategoryListSmallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BTCategoryListSmallCell class]) forIndexPath:indexPath];
        if (_type_id == 1) {
            BTCategoryListModal *listModal = [self.goodListModalArray validObjectForIndex:indexPath.item];
            [cell setCellInfoWithModal:listModal];
        } else {
            BTCategoryListModal *listModal = [self.allListModalArray validObjectForIndex:indexPath.item];
            [cell setCellInfoWithModal:listModal];
        }
        return cell;
    } else {
        BTCategoryListBigCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BTCategoryListBigCell class]) forIndexPath:indexPath];
        //cell的代理赋值
        cell.delegete = self;
        if (_type_id == 1) {
            BTCategoryListModal *listModal = [self.goodListModalArray validObjectForIndex:indexPath.item];
            [cell setCellInfoWithModal:listModal];
        } else {
            BTCategoryListModal *listModal = [self.allListModalArray validObjectForIndex:indexPath.item];
            [cell setCellInfoWithModal:listModal];
        }
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader && indexPath.section == 0) {
        BTCategoryHeadReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([BTCategoryHeadReusableView class]) forIndexPath:indexPath];
        [headView setViewInfoWithArray:self.categorySubClassModalArray];
        return headView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(ScreenWidth, 100);
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (_isBig == NO) {
       return UIEdgeInsetsMake(10, 10, 10, 10);
    } else {
        return UIEdgeInsetsMake(10, 0, 10, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_isBig == NO) {
        return [collectionView ar_sizeForCellWithIdentifier:NSStringFromClass([BTCategoryListSmallCell class]) indexPath:indexPath fixedWidth:ImgVSmallHeight configuration:^(__kindof BTCategoryListSmallCell *cell) {
            if (_type_id == 1) {
                BTCategoryListModal *listModal = [self.goodListModalArray validObjectForIndex:indexPath.item];
                [cell setCellInfoWithModal:listModal];
            } else {
                BTCategoryListModal *listModal = [self.allListModalArray validObjectForIndex:indexPath.item];
                [cell setCellInfoWithModal:listModal];
            }
        }];
    } else {
        return [collectionView ar_sizeForCellWithIdentifier:NSStringFromClass([BTCategoryListBigCell class]) indexPath:indexPath fixedWidth:ScreenWidth configuration:^(__kindof BTCategoryListBigCell *cell) {
            if (_type_id == 1) {
                BTCategoryListModal *listModal = [self.goodListModalArray validObjectForIndex:indexPath.item];
                [cell setCellInfoWithModal:listModal];
            } else {
                BTCategoryListModal *listModal = [self.allListModalArray validObjectForIndex:indexPath.item];
                [cell setCellInfoWithModal:listModal];
            }
        }];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_isBig == NO) {
        BTGoodsDetailVC *goodsDetailVC = [[BTGoodsDetailVC alloc]init];
        if (_type_id == 1) {
            BTCategoryListModal *listModal = [self.goodListModalArray validObjectForIndex:indexPath.item];
            goodsDetailVC.id_ = listModal.id_;
        } else {
            BTCategoryListModal *listModal = [self.allListModalArray validObjectForIndex:indexPath.item];
            goodsDetailVC.id_ = listModal.id_;
        }
        [self.navigationController pushViewController:goodsDetailVC animated:YES];
    }
}

#pragma mark - Click_Event

- (void)onLeftBarButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

//切换布局
- (void)onRightBarButtonClick:(UIButton *)sender {
    _isBig = !_isBig;
    if (_isBig == YES) {
        [sender setImage:[UIImage imageNamed:@"btn_group_switch_collection_23x23_"] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"btn_group_switch_list_24x20_"] forState:UIControlStateNormal];
    }
    [self.collV reloadData];
}

//切换全部或者精选类型
- (void)onChangeTypeButtonClick:(UIButton *)sender {
    if (sender.tag == _selectedBtn.tag) {
        return;
    }
    if (sender.tag == 2) {
        //精选按钮
        _type_id = 1;
    } else {
        //全部按钮
        _type_id = 0;
    }
    [self.collV reloadData];
    [self.collV setContentOffset:CGPointMake(0, 0) animated:YES];
    self.collV.mj_footer.state = MJRefreshStateIdle;
    _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_selectedBtn setTitleColor:ItemBackgroundColor forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:17];
    [sender setTitleColor:TitleDarkColor forState:UIControlStateNormal];
    _selectedBtn = sender;
}

/**点击作者头像*/
- (void)onListBigCellAuthorAvatarButtonClickAuthorId:(NSString *)authorID {
    [MBProgressHUD showMessage:[NSString stringWithFormat:@"点击了作者头像 authorId:%@",authorID]];
}
/**点击评论按钮*/
- (void)onListBigCellCommentButtonClick {
    [MBProgressHUD showMessage:@"评论按钮点击"];
}
/**点击喜欢按钮*/
- (void)onListBigCellLikeButtonClick{
    [MBProgressHUD showMessage:@"喜欢按钮点击"];
}
/**分享按钮点击*/
- (void)onListBigCellShareButtonClick{
    [MBProgressHUD showMessage:@"分享按钮点击"];
}
/**更多按钮点击*/
- (void)onListBigCellMoreButtonClick{
    [MBProgressHUD showMessage:@"更多按钮点击"];
}
/**点击链接*/
- (void)onListBigCellLinkViewClick{
    [MBProgressHUD showMessage:@"链接点击"];
}
/**喜欢详情按钮点击*/
- (void)onListBigCellLikeDetailButtonClick{
    [MBProgressHUD showMessage:@"喜欢详情点击"];
}
/**评论详情按钮点击*/
- (void)onListBigCellCommentDetailButtonClick{
    [MBProgressHUD showMessage:@"评论详情点击"];
}


@end
