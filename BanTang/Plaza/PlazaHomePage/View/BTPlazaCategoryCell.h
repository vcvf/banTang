//
//  BTPlazaCategoryCell.h
//  BanTang
//
//  Created by guanli on 16/4/19.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTPlazaCategoryModal.h"

@protocol BTPlazaHomePageCategoryCellSelected <NSObject>

- (void)onHomePageCategoryCellSelectedWithIndex:(NSInteger)index;//点击了banner上得图片

@end

@interface BTPlazaCategoryCell : UICollectionViewCell

@property (nonatomic, assign)id<BTPlazaHomePageCategoryCellSelected> delegate;

@property (nonatomic, retain)UIScrollView *scrollV;
@property (nonatomic, retain)UIPageControl *pageC;

- (void)setCellInfoWithArray:(NSArray *)modalArray;

@end
