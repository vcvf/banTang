//
//  BTCustomTabBarC.m
//  BanTang
//
//  Created by guanli on 16/3/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTCustomTabBarC.h"
#import "BTHomeVC.h"
#import "BTPlazaVC.h"
#import "BTMessageVC.h"
#import "BTPersonalVC.h"
#import "BTPlusVC.h"

@interface BTCustomTabBarC () <UITabBarDelegate>

@property (nonatomic, retain)NSArray *normalImgArray;
@property (nonatomic, retain)NSArray *selectImgArray;
@property (nonatomic, retain)UIButton *selectBtn;

@end

@implementation BTCustomTabBarC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //self.tabBar.frame = CGRectMake(0, ScreenHeight-TabBarHeight, ScreenWidth, TabBarHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.tabBar.frame = CGRectMake(0,ScreenHeight-TabBarHeight, ScreenWidth, TabBarHeight);
    //self.tabBar.clipsToBounds = YES;//去黑线
    
    BTHomeVC *homeVC = [[BTHomeVC alloc]init];
    UITabBarItem *homeItem = [[UITabBarItem alloc]initWithTabBarSystemItem:0 tag:0];
    homeVC.tabBarItem = homeItem;
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    
    BTPlazaVC *plazaVC = [[BTPlazaVC alloc]init];
    UITabBarItem *plazaItem = [[UITabBarItem alloc]initWithTabBarSystemItem:0 tag:0];
    plazaVC.tabBarItem = plazaItem;
    UINavigationController *plazaNav = [[UINavigationController alloc]initWithRootViewController:plazaVC];
    
    BTMessageVC *messageVC  =[[BTMessageVC alloc]init];
    UITabBarItem *messageItem = [[UITabBarItem alloc]initWithTabBarSystemItem:0 tag:0];
    messageVC.tabBarItem = messageItem;
    UINavigationController *messageNav = [[UINavigationController alloc]initWithRootViewController:messageVC];
    
    BTPersonalVC *personalVC = [[BTPersonalVC alloc]init];
    UITabBarItem *personalItem = [[UITabBarItem alloc]initWithTabBarSystemItem:3 tag:0];
    personalVC.tabBarItem = personalItem;
    UINavigationController *personalNav = [[UINavigationController alloc]initWithRootViewController:personalVC];
    self.viewControllers = @[homeNav,plazaNav,messageNav,personalNav];

    self.normalImgArray = @[[UIImage imageNamed:@"tab_首页_24x24_"],[UIImage imageNamed:@"tab_社区_26x23_"],[UIImage imageNamed:@"tab_分类_27x21_"],[UIImage imageNamed:@"tab_我的_22x23_"],[UIImage imageNamed:@"tab_publish_add_36x32_"]];
    self.selectImgArray = @[[UIImage imageNamed:@"tab_首页_pressed_24x24_"],[UIImage imageNamed:@"tab_社区_pressed_26x23_"],[UIImage imageNamed:@"tab_分类_pressed_27x21_"],[UIImage imageNamed:@"tab_我的_pressed_22x23_"],[UIImage imageNamed:@"tab_publish_add_pressed_36x32_"]];
    
    CGFloat btnW = ScreenWidth/5.0;
    for (int i = 0;i < 5;i ++) {
        UIButton *btn = [[UIButton alloc]init];
        CGFloat x = btnW * i;
        btn.frame = CGRectMake(x, 0, btnW, TabBarHeight);
        btn.tag = i;
        if (i == 2) {
            btn.tag = 4;
        }
        if (i>2) {
            btn.tag = i-1;
        }
        [btn setImage:self.normalImgArray[btn.tag] forState:UIControlStateNormal];
        if (i == 0) {
            //中间相册按钮
            self.selectBtn = btn;
            [btn setImage:self.selectImgArray[btn.tag] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor whiteColor];
        [self.tabBar addSubview:btn];
    }

}

- (void)test:(UIButton *)sender {
    if (sender.tag == self.selectBtn.tag) {
        return;
    }
    if (sender.tag != 4) {
        self.selectedViewController = self.viewControllers[sender.tag];
        [self.selectBtn setImage:self.normalImgArray[self.selectBtn.tag] forState:UIControlStateNormal];
        [sender setImage:self.selectImgArray[sender.tag] forState:UIControlStateNormal];
        self.selectBtn = sender;
    } else {
        //tabBar中间加号按钮点击
        BTPlusVC *plusVC = [[BTPlusVC alloc]init];
        [self presentViewController:plusVC animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
