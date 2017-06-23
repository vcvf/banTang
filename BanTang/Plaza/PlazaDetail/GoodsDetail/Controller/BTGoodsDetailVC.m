//
//  BTGoodsDetailVC.m
//  BanTang
//
//  Created by guanli on 16/4/26.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTGoodsDetailVC.h"
#import "BTGoodsDetailCell.h"

#import "BTPlazaNetWorkRequest.h"
#import "BTGoodsDetailModal.h"

@interface BTGoodsDetailVC () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BTCategoryListBigCellDelegate>

@property (nonatomic, retain)UICollectionView *collV;
@property (nonatomic, retain)UIView *navBarView;
@property (nonatomic, retain)NSMutableArray *goodsModalArray;
@property (nonatomic, retain)BTGoodsDetailModal *goodsDetailModal;

@end

@implementation BTGoodsDetailVC

#pragma mark - Lazy

- (NSMutableArray *)goodsModalArray {
    if (!_goodsModalArray) {
        _goodsModalArray = [[NSMutableArray alloc]init];
    }
    return _goodsModalArray;
}

#pragma mark - SetUpUI

- (UIView *)navBarView {
    if (!_navBarView) {
        _navBarView = [[UIView alloc]init];
        _navBarView.backgroundColor = TopicColor;
        _navBarView.frame = CGRectMake(0, 0, ScreenWidth, 63);
        
        UIButton *leftItem = [[UIButton alloc] init];
        [leftItem setImage:[UIImage imageNamed:@"tb_icon_navigation_back"] forState:UIControlStateNormal];
        [leftItem addTarget:self action:@selector(onLeftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_navBarView addSubview:leftItem];
        [leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_navBarView).offset(10);
            make.left.equalTo(_navBarView).offset(5);
            make.width.height.equalTo(@30);
        }];
        
        UILabel *labTitle = [[UILabel alloc]init];
        labTitle.textColor = [UIColor whiteColor];
        labTitle.font = [UIFont systemFontOfSize:17];
        labTitle.text = @"好物详情";
        [_navBarView addSubview:labTitle];
        [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_navBarView).offset(10);
            make.centerX.equalTo(_navBarView);
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
        
        [_collV registerClass:[BTGoodsDetailCell class] forCellWithReuseIdentifier:NSStringFromClass([BTGoodsDetailCell class])];
        
        _collV.delegate = self;
        _collV.dataSource = self;
    }
    return _collV;
}

- (void)setUpUI {
    [self.view addSubview:self.navBarView];
    [self.view addSubview:self.collV];
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
    
    /**设置UI界面*/
    [self setUpUI];
    /**获取好物精选详情数据*/
    [self getGoodsDetailData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NetWorkRequest

- (void)getGoodsDetailData {
    BTURLParameterManager *parameterDic = [BTURLParameterManager sharedInstance];
    [parameterDic setObject:[NSDate unixDateString] forKey:@"app_installtime"];
    [parameterDic setObject:self.id_ forKey:@"id"];
    [[BTPlazaNetWorkRequest sharedInstance] getGoodsDetailDataWithDictionary:parameterDic success:^(id obj) {
        //添加详情模型到数组
        self.goodsDetailModal = obj;
        [self.goodsModalArray addObject:self.goodsDetailModal];
        //刷新表
        [self.collV reloadData];
    } failure:^(id obj) {
        
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.goodsModalArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BTGoodsDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BTGoodsDetailCell class]) forIndexPath:indexPath];
    //给代理对象赋值
    cell.delegete = self;
    [cell setCellInfoWithModal:[self.goodsModalArray validObjectForIndex:indexPath.item]];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView ar_sizeForCellWithIdentifier:NSStringFromClass([BTGoodsDetailCell class]) indexPath:indexPath fixedWidth:ScreenWidth configuration:^(__kindof UICollectionViewCell *cell) {
        [cell setCellInfoWithModal:[self.goodsModalArray validObjectForIndex:indexPath.item]];
    }];
}

#pragma mark - Click_Event

- (void)onLeftBarButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
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
