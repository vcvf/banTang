//
//  BTDIYFooter.m
//  BanTang
//
//  Created by guanli on 16/4/20.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTDIYFooter.h"

@interface BTDIYFooter ()

@property (nonatomic, retain)UILabel *lab;
@property (nonatomic, retain)UIActivityIndicatorView *loading;

@end

@implementation BTDIYFooter

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）

- (void)prepare {
    [super prepare];
    //无数据的时候就隐藏
    self.automaticallyHidden = YES;
    //当底部控件出现多少时自动刷新
    self.triggerAutomaticallyRefreshPercent = -40;
    
    //设置控件的高度
    self.mj_h = 50;
    
    //添加label
    UILabel *lab = [[UILabel alloc]init];
    lab.textColor = TopicColor;
    lab.font = [UIFont fontWithName:@"Zapfino" size:17];
    lab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lab];
    self.lab = lab;
    
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸

- (void)placeSubviews {
    [super placeSubviews];
    [self.lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(10);
        make.left.greaterThanOrEqualTo(self);
        make.right.lessThanOrEqualTo(self);
    }];
    
    [self.loading mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.lab.mas_left).offset(0);
        make.height.width.equalTo(@50);
    }];
}

#pragma mark 监听scrollView的contentOffset改变

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变

- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            self.lab.text = @"Lors de visites";
            break;
        case MJRefreshStatePulling:
            [self.loading stopAnimating];
            self.lab.text = @"Lors de visites";
            break;
        case MJRefreshStateRefreshing:
            self.lab.text = @"Lors de ···";
            [self.loading startAnimating];
            break;
        case MJRefreshStateNoMoreData:
            self.lab.text = @"No More here";
            [self.loading stopAnimating];
            break;
        default:
            break;
    }
}

@end
