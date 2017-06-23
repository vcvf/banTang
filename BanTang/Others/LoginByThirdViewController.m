//
//  LoginByThirdViewController.m
//  BanTang
//
//  Created by guanli on 16/5/30.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "LoginByThirdViewController.h"

@interface LoginByThirdViewController ()

@property (nonatomic, retain)UIButton *btnEnd;
@property (nonatomic, retain)UIButton *btnLoginByTelephone;
@property (nonatomic, retain)UIImageView *imgVLogo;
@property (nonatomic, retain)UILabel *labLogo;
@property (nonatomic, retain)UILabel *labLoginType;
@property (nonatomic, retain)UIButton *btnWeiXin;
@property (nonatomic, retain)UIButton *btnSina;
@property (nonatomic, retain)UIButton *btnQQ;

@end

@implementation LoginByThirdViewController

#pragma mark - Lazy

- (UIButton *)btnEnd {
    if (!_btnEnd) {
        _btnEnd = [[UIButton alloc]init];
        [_btnEnd setImage:[UIImage imageNamed:@"btn_article_edit_delete_30x30_"] forState:UIControlStateNormal];
        [_btnEnd addTarget:self action:@selector(onEndButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnEnd;
}

#pragma mark - SetUpUI

- (void)setUpUI {
    [self.view addSubview:self.btnEnd];
    [self.btnEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(20+10));
        make.left.equalTo(@10);
        make.width.height.equalTo(@30);
    }];
}

#pragma mark - ViewLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Click_Event

- (void)onEndButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
