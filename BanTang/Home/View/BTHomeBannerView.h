//
//  BTHomeBannerView.h
//  BanTang
//
//  Created by guanli on 16/5/23.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTHomeBannerView : UIView <SDCycleScrollViewDelegate>

@property (nonatomic, retain)SDCycleScrollView *scrollView;

- (void)setBannerInfoWithArray:(NSArray *)bannerModalArrary;

@end
