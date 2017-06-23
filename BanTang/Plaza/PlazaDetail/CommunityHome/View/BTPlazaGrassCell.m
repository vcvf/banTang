//
//  BTPlazaGrassCell.m
//  BanTang
//
//  Created by guanli on 16/5/6.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPlazaGrassCell.h"

#define ImgVHeight

@implementation BTPlazaGrassCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _imgVPic = [[UIImageView alloc] init];
        _imgVPic.contentMode = UIViewContentModeScaleAspectFill;
        _imgVPic.layer.masksToBounds = YES;
        _imgVPic.backgroundColor = ItemBackgroundColor;
        [self.contentView addSubview:_imgVPic];
        [_imgVPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(4);
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@((ScreenWidth - 10*2)*0.38));
            make.bottom.equalTo(self.contentView).offset(-4).priority(750);
        }];
        
        _imgVTitle = [[UIImageView alloc] init];
        [_imgVPic addSubview:_imgVTitle];
        [_imgVTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(_imgVPic.mas_top).offset((ScreenWidth - 10*2)*0.38 * 0.33);
            make.width.equalTo(_imgVPic.mas_width).multipliedBy(0.45);
            make.height.equalTo(_imgVPic.mas_width).multipliedBy(0.45*0.2);
        }];
        
        UIView *viewBottom = [[UIView alloc] init];
        [_imgVPic addSubview:viewBottom];
        [viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_imgVPic);
            make.top.equalTo(_imgVTitle.mas_bottom).offset(7);
            make.left.greaterThanOrEqualTo(_imgVPic.mas_left).offset(10);
            make.right.lessThanOrEqualTo(_imgVPic.mas_right).offset(-10);
            make.bottom.lessThanOrEqualTo(_imgVPic.mas_bottom).offset(-10);
        }];
        
        _labViews = [[UILabel alloc] init];
        _labViews.textColor = [UIColor whiteColor];
        _labViews.font = [UIFont systemFontOfSize:11];
        [viewBottom addSubview:_labViews];
        [_labViews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(viewBottom);
            make.right.lessThanOrEqualTo(viewBottom);
        }];
        
        _labPosts = [[UILabel alloc] init];
        _labPosts.textColor = [UIColor whiteColor];
        _labPosts.font = [UIFont systemFontOfSize:11];
        [viewBottom addSubview:_labPosts];
        [_labPosts mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(viewBottom);
            make.left.greaterThanOrEqualTo(viewBottom);
            make.left.equalTo(_labViews.mas_right).offset(10);
        }];
        
    }
    return self;
}

- (void)setCellInfoWithModal:(BTPlazaGrassModal *)grassModal {
    [_imgVPic yy_setImageWithURL:[NSURL URLWithString:grassModal.pic2] options:YYWebImageOptionSetImageWithFadeAnimation];
    [_imgVTitle yy_setImageWithURL:[NSURL URLWithString:grassModal.pic3] options:YYWebImageOptionSetImageWithFadeAnimation];
    _labViews.text = [NSString stringWithFormat:@"%@浏览",[grassModal.dynamic validObjectForKey:@"views"]];
    _labPosts.text = [NSString stringWithFormat:@"%@帖子",[grassModal.dynamic validObjectForKey:@"posts"]];
}

@end
