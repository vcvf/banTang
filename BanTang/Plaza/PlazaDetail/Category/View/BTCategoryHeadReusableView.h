//
//  BTCategoryHeadReusableView.h
//  BanTang
//
//  Created by guanli on 16/4/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTCategoryHeadReusableView : UICollectionReusableView

@property (nonatomic, retain)UIScrollView *scrollV;

- (void)setViewInfoWithArray:(NSArray *)subclassModalArray;

@end
