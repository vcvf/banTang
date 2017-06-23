//
//  BTPlazaCategoryCell.m
//  BanTang
//
//  Created by guanli on 16/4/19.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPlazaCategoryCell.h"

@interface BTPlazaCategoryCell () <UIScrollViewDelegate> {
    NSArray *_categoryModalArray;
}

@end

@implementation BTPlazaCategoryCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _scrollV = [[UIScrollView alloc]init];
        _scrollV.backgroundColor = [UIColor whiteColor];
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.pagingEnabled = YES;
        _scrollV.delegate = self;
        [self.contentView addSubview:_scrollV];
        [_scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-30);
        }];
        
        _pageC = [[UIPageControl alloc]init];
        _pageC.currentPageIndicatorTintColor = TopicColor;
        _pageC.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageC.userInteractionEnabled = NO;
        [self.contentView addSubview:_pageC];
        [_pageC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollV.mas_bottom);
            make.right.left.equalTo(self.contentView);
            make.height.equalTo(@(30));
        }];
    }
    return self;
}

- (void)setCellInfoWithArray:(NSArray *)modalArray {
    //如果获取到的数组与本地数组一样则不执行
    if ([modalArray isEqualToArray:_categoryModalArray]) {
        return;
    }
    
    //移除子视图
    for (UIButton *control in self.scrollV.subviews) {
        [control removeFromSuperview];
    }
    
    //增加分类视图
    UIButton *tempLeftControl = nil;
    UIButton *tempRightControl = nil;
    NSInteger controlWidth = (ScreenWidth - 3*10)/2.0;
    NSInteger controlHeight = (ScreenWidth - 3*10)/2.0 * 0.46;
    for (int i = 0;i < modalArray.count;i ++) {
        UIButton *control = [[UIButton alloc]init];
        control.contentMode = UIViewContentModeScaleAspectFill;
        control.layer.cornerRadius = 3.0;
        control.layer.masksToBounds = YES;
        control.backgroundColor = ItemBackgroundColor;
        control.tag = i;
        [control addTarget:self action:@selector(onCategoryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollV addSubview:control];
        
        if (i<6) {
            //左边一大块
            if (tempLeftControl == nil) {
                //第一个
                [control mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.scrollV).offset(0);
                    make.left.equalTo(self.scrollV).offset(10);
                    make.width.equalTo(@(controlWidth));
                    make.height.equalTo(@(controlHeight));
                }];
            } else {
                if (i % 2 == 1) {
                    //右边的
                    [control mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(tempLeftControl.mas_top);
                        make.left.equalTo(tempLeftControl.mas_right).offset(10);
                        make.width.equalTo(@(controlWidth));
                        make.height.equalTo(@(controlHeight));
                    }];
                } else {
                    //左边的
                    [control mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(tempLeftControl.mas_bottom).offset(10);
                        make.left.equalTo(self.scrollV).offset(10);
                        make.width.equalTo(@(controlWidth));
                        make.height.equalTo(@(controlHeight));
                    }];
                }
            }
            tempLeftControl = control;
        } else {
            //右边一大块 i从6开始
            if (tempRightControl == nil) {
                //第一个
                [control mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.scrollV).offset(0);
                    make.left.equalTo(tempLeftControl.mas_right).offset(10*2);
                    make.width.equalTo(@(controlWidth));
                    make.height.equalTo(@(controlHeight));
                }];
            } else {
                if (i % 2 == 1) {
                    //右边
                    [control mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(tempRightControl.mas_top);
                        make.left.equalTo(tempRightControl.mas_right).offset(10);
                        make.width.equalTo(@(controlWidth));
                        make.height.equalTo(@(controlHeight));
                    }];
                } else {
                    //左边
                    [control mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(tempRightControl.mas_bottom).offset(10);
                        make.left.equalTo(tempLeftControl.mas_right).offset(10*2);
                        make.width.equalTo(@(controlWidth));
                        make.height.equalTo(@(controlHeight));
                    }];
                }
            }
            
            tempRightControl = control;
        }
        
        
        BTPlazaCategoryModal *modal = [modalArray validObjectForIndex:i];
        [control yy_setBackgroundImageWithURL:[NSURL URLWithString:modal.pic] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
        [control yy_setBackgroundImageWithURL:[NSURL URLWithString:modal.pic] forState:UIControlStateHighlighted options:YYWebImageOptionSetImageWithFadeAnimation];
    }
    
    //更改scrollView的frame
    [self.scrollV mas_updateConstraints:^(MASConstraintMaker *make) {
        if ((modalArray.count-1) < 6) {
            //左边一大块
            make.height.mas_equalTo(((modalArray.count-1)/2+1)*(controlHeight+10)-10);
        } else {
            //右边一大块
            make.height.mas_equalTo((5/2+1)*(controlHeight+10)-10);
        }
    }];
    
    //更改scrollView得contentSize
    if ((modalArray.count - 1) < 6) {
        self.scrollV.contentSize = CGSizeMake(ScreenWidth, ((modalArray.count-1)/2+1)*(controlHeight+10)-10);
    } else {
        self.scrollV.contentSize = CGSizeMake(ScreenWidth*2, (5/2+1)*(controlHeight+10)-10);
    }
    
    //赋值本地数组
    _categoryModalArray = modalArray;
    //赋值pagecontroller的pages
    self.pageC.numberOfPages = (modalArray.count - 1)/6 + 1;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageC.currentPage =  scrollView.contentOffset.x / ScreenWidth;
}

#pragma mark - Click_Event

- (void)onCategoryClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(onHomePageCategoryCellSelectedWithIndex:)]) {
        [self.delegate onHomePageCategoryCellSelectedWithIndex:sender.tag];
    }
}

@end
