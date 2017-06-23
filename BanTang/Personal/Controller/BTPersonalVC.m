//
//  BTPersonalVC.m
//  BanTang
//
//  Created by guanli on 16/3/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPersonalVC.h"

@interface BTPersonalVC ()

@property (nonatomic, retain)UICollectionView *collV;
@property (nonatomic, retain)UIView *navBarView;

@end

@implementation BTPersonalVC

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
        labTitle.text = @"个人中心";
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
        _collV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NavBarHeight, ScreenWidth, ScreenHeight-NavBarHeight) collectionViewLayout:layout];
        _collV.backgroundColor = BackgroundColor;
        
    }
    return _collV;
}

- (void)setUpUI {
    
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Click_Event

- (void)onLeftBarButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
