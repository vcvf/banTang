//
//  BTPlazaBannerCell.m
//  BanTang
//
//  Created by guanli on 16/4/19.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPlazaBannerCell.h"

@implementation BTPlazaBannerCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 0, 0) delegate:self placeholderImage:nil];
        _scrollView.backgroundColor = ItemBackgroundColor;
        _scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _scrollView.hidesForSinglePage = NO;
        _scrollView.currentPageDotColor = [UIColor yellowColor];
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    //代理方法执行
    if ([self.delegate respondsToSelector:@selector(onHomePageBannerCellSelectedWithIndex:)]) {
        [self.delegate onHomePageBannerCellSelectedWithIndex:index];
    }
}

@end
