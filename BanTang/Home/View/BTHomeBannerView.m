//
//  BTHomeBannerView.m
//  BanTang
//
//  Created by guanli on 16/5/23.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTHomeBannerView.h"
#import "BTHomeBannerModal.h"

@implementation BTHomeBannerView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, 0, 0) delegate:self placeholderImage:nil];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _scrollView.currentPageDotColor = [UIColor yellowColor];
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(-45);
        }];    }
    return self;
}

- (void)dealloc {
    NSLog(@"释放了");
}

- (void)setBannerInfoWithArray:(NSArray *)bannerModalArrary {
    NSMutableArray *imageUrlArray = [NSMutableArray array];
    for (BTHomeBannerModal *modal in bannerModalArrary) {
        [imageUrlArray addObject:modal.photo];
    }
    self.scrollView.imageURLStringsGroup = imageUrlArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
