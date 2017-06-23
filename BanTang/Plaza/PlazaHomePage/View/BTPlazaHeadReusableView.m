//
//  BTPlazaHeadReusableView.m
//  BanTang
//
//  Created by guanli on 16/4/19.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPlazaHeadReusableView.h"

@implementation BTPlazaHeadReusableView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _imgV = [[UIImageView alloc]init];
        [self addSubview:_imgV];
        
        _labTitle = [[UILabel alloc]init];
        _labTitle.textColor = [UIColor grayColor];
        _labTitle.font = [UIFont systemFontOfSize:15];
        [self addSubview:_labTitle];
        
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(10);
            make.width.height.equalTo(@15);
        }];
        
        [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_imgV.mas_right).offset(10);
            make.right.lessThanOrEqualTo(self).offset(-20);
        }];
    }
    return self;
}

@end
