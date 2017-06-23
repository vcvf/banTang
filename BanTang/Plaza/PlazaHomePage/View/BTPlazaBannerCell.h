//
//  BTPlazaBannerCell.h
//  BanTang
//
//  Created by guanli on 16/4/19.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTPlazaBannerModal.h"

@protocol BTPlazaHomePageBannerCellSelected <NSObject>

- (void)onHomePageBannerCellSelectedWithIndex:(NSInteger)index;//点击了banner上得图片

@end

@interface BTPlazaBannerCell : UICollectionViewCell <SDCycleScrollViewDelegate>

@property (nonatomic, assign)id<BTPlazaHomePageBannerCellSelected> delegate;

@property (nonatomic, retain)SDCycleScrollView *scrollView;

@end
