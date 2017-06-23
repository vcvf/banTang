//
//  BTHomeCategoryScrollView.h
//  BanTang
//
//  Created by guanli on 16/4/14.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BTHomeCategoryScrollView;

@protocol BTHomeCategoryScrollViewDelegate <NSObject>

- (void)onBTHomeCategoryScrollViewClicked:(BTHomeCategoryScrollView *)categoryScrollView atIndex:(NSInteger)index;

@end

@interface BTHomeCategoryScrollView : UIScrollView

@property (nonatomic, assign)id<BTHomeCategoryScrollViewDelegate> categoryDelegate;
@property (nonatomic, retain)NSMutableArray *arrayTitle;

- (void)categoryScrollViewScrollToIndex:(NSInteger)index;

@end
