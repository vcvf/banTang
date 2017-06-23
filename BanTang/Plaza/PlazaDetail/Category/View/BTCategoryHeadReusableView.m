//
//  BTCategoryHeadReusableView.m
//  BanTang
//
//  Created by guanli on 16/4/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTCategoryHeadReusableView.h"
#import "BTCategorySubclassModal.h"

@interface BTCategoryHeadReusableView () {
    NSArray *_localSubclassModalArray;
}

@end

@implementation BTCategoryHeadReusableView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _scrollV = [[UIScrollView alloc]init];
        _scrollV.backgroundColor = [UIColor whiteColor];
        [self addSubview:_scrollV];
        [_scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)setViewInfoWithArray:(NSArray *)subclassModalArray {
    
    if ([subclassModalArray isEqualToArray:_localSubclassModalArray]) {
        return;
    }
    
    for (UIView *view in self.scrollV.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat btnW = 70;
    for (int i = 0;i < subclassModalArray.count;i ++) {
        BTCategorySubclassModal *modal = [subclassModalArray validObjectForIndex:i];
        UIImageView *imgV = [[UIImageView alloc]init];
        imgV.backgroundColor = ItemBackgroundColor;
        imgV.layer.cornerRadius = 3.0;
        imgV.layer.masksToBounds = YES;
        imgV.frame = CGRectMake(15 + (btnW+10)*i, 15, btnW, btnW);
        [self.scrollV addSubview:imgV];
        [imgV yy_setImageWithURL:[NSURL URLWithString:modal.pic] options:YYWebImageOptionSetImageWithFadeAnimation];
        
        UILabel *labTitle = [[UILabel alloc]init];
        labTitle.textColor = [UIColor whiteColor];
        labTitle.numberOfLines = 1;
        labTitle.font = [UIFont systemFontOfSize:15];
        labTitle.text = modal.name;
        [imgV addSubview:labTitle];
        [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(imgV);
        }];
    }
    //设置contentSize
    self.scrollV.contentSize = CGSizeMake(15 + (btnW+10)*subclassModalArray.count+5, 100);
    //赋值本地数组
    if (subclassModalArray.count != 0) {
        _localSubclassModalArray = subclassModalArray;
    }
}

@end
