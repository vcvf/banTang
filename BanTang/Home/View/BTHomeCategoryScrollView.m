//
//  BTHomeCategoryScrollView.m
//  BanTang
//
//  Created by guanli on 16/4/14.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTHomeCategoryScrollView.h"
#import "BTHomeCategoryModal.h"

#define padding 20

@interface  BTHomeCategoryScrollView () {
    UIButton *selectBtn;
    UIView *bottomLineView;
}

@end

@implementation BTHomeCategoryScrollView

- (id)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self; 
}

- (void)setArrayTitle:(NSMutableArray *)arrayTitle {
    UIButton *lastBtn = nil;
    for (int i = 0;i < arrayTitle.count+1;i ++) {
        BTHomeCategoryModal *categoryModal = nil;
        NSString *btnTitle = nil;
        if (i > 0) {
            categoryModal = [arrayTitle validObjectForIndex:i-1];
            btnTitle = categoryModal.title;
        }
        CGSize size = [btnTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        CGFloat btnWidth = size.width;
        
        if (i == 0) {
            btnTitle = @"最新";
            size = [btnTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
            btnWidth = size.width;
        }
        
        UIButton *categoryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [categoryBtn setTitle:btnTitle forState:UIControlStateNormal];
        [categoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        categoryBtn.tag = i+100;
        [categoryBtn addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:categoryBtn];
        
        if (lastBtn == nil) {
            //第一个按钮
            categoryBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            categoryBtn.frame = CGRectMake(padding, 0, btnWidth, 42);
            [categoryBtn setTitleColor:TopicColor forState:UIControlStateNormal];
            selectBtn = categoryBtn;
            //添加底部条
            bottomLineView = [[UIView alloc]init];
            bottomLineView.backgroundColor = TopicColor;
            bottomLineView.bounds = CGRectMake(0, 0, size.width, 3);
            bottomLineView.center = CGPointMake(categoryBtn.center.x, 43.5);
            [self addSubview:bottomLineView];
        } else {
            categoryBtn.frame = CGRectMake(lastBtn.frame.origin.x+lastBtn.frame.size.width+padding, 0, btnWidth, 42);
            categoryBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        lastBtn = categoryBtn;
    }
    
    self.contentSize = CGSizeMake(lastBtn.frame.origin.x+lastBtn.frame.size.width+padding, 30);
    _arrayTitle = arrayTitle;
}

- (void)onButtonClick:(UIButton *)sender {
    [selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sender setTitleColor:TopicColor forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:16];
    [UIView animateWithDuration:0.3 animations:^{
        bottomLineView.bounds = CGRectMake(0, 0,sender.frame.size.width, 3);
        bottomLineView.center = CGPointMake(sender.center.x, 43.5);
    }];
    selectBtn = sender;
    
    
    if ([_categoryDelegate respondsToSelector:@selector(onBTHomeCategoryScrollViewClicked:atIndex:)]) {
        [_categoryDelegate onBTHomeCategoryScrollViewClicked:self atIndex:sender.tag - 100];
    }
}

- (void)dealloc {
    NSLog(@"释放了");
}

- (void)categoryScrollViewScrollToIndex:(NSInteger)index {
    UIButton *button = [self viewWithTag:100 + index];
    [self onButtonClick:button];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
