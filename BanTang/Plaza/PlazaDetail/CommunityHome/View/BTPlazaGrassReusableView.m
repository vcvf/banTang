//
//  BTPlazaGrassReusableView.m
//  BanTang
//
//  Created by guanli on 16/5/6.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPlazaGrassReusableView.h"

@implementation BTPlazaGrassReusableView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _btnChange = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnChange setTitleColor:TitleLightColor forState:UIControlStateNormal];
        [_btnChange setTitleColor:TitleLightColor forState:UIControlStateHighlighted];
        _btnChange.titleLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_btnChange];
        [_btnChange mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        UIView *viewLineLeft = [[UIView alloc] init];
        viewLineLeft.backgroundColor = ItemBackgroundColor;
        [self addSubview:viewLineLeft];
        [viewLineLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(_btnChange.mas_left).offset(-5);
            make.height.equalTo(@1);
        }];
        
        UIView *viewLineRight = [[UIView alloc] init];
        viewLineRight.backgroundColor = ItemBackgroundColor;
        [self addSubview:viewLineRight];
        [viewLineRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_btnChange.mas_right).offset(5);
            make.right.equalTo(self).offset(-10);
            make.height.equalTo(@1);
        }];
    }
    return self;
}

@end
