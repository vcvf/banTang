//
//  BTLeftListView.h
//  BanTang
//
//  Created by guanli on 16/4/26.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ListViewAlignStyle) {
    ListViewAlignStyleCenter,
    ListViewAlignStyleLeft,
    ListViewAlignStyleRight,
};

#define TriangleHeight 6.0
#define TriangleWidth 9.0
#define ListViewCornerRadius 3
#define ListViewRoundMargin 0.0

@class BTPlazaLeftListView;
@protocol BTPlazaLeftListViewDelegate <NSObject>

- (void)listViewDidShow:(BTPlazaLeftListView *)pView;
- (void)listViewDidDismiss:(BTPlazaLeftListView *)pView;

- (void)showListView:(BTPlazaLeftListView *)listView didClickAtIndex:(NSInteger)index;

@end

@interface BTPlazaLeftListView : UIView

@property (nonatomic, assign)id<BTPlazaLeftListViewDelegate> delegate;
@property (nonatomic, retain)UIView *contentView;
@property (nonatomic, retain)UIViewController *contentViewController;

@property (nonatomic, retain)UIColor *containerBackgroudColor;

+ (instancetype)popOverView;

- (instancetype)initWithBounds:(CGRect)bounds titleMenus:(NSArray *)titles;


- (void)showFrom:(UIView *)from alignStyle:(ListViewAlignStyle)style;

- (void)dismiss;

@end
