//
//  BTCategoryListSmallCell.m
//  BanTang
//
//  Created by guanli on 16/4/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTCategoryListSmallCell.h"

#define ImgVSmallHeight (ScreenWidth - 10*3)/2.0

@implementation BTCategoryListSmallCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _imgPic = [[UIImageView alloc]init];
        _imgPic.contentMode = UIViewContentModeScaleAspectFill;
        _imgPic.layer.masksToBounds = YES;
        _imgPic.backgroundColor = ItemBackgroundColor;
        [self.contentView addSubview:_imgPic];
        [_imgPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.contentView);
            make.height.equalTo(@(ImgVSmallHeight));
            make.bottom.lessThanOrEqualTo(self.contentView);
        }];
        
        _imgAvatar = [[UIImageView alloc] init];
        //_imgAvatar.backgroundColor = ItemBackgroundColor;
        [self.contentView addSubview:_imgAvatar];
        [_imgAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imgPic.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(10);
            make.height.width.equalTo(@20);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-10);
        }];
        
        _labNickname = [[UILabel alloc]init];
        _labNickname.backgroundColor = ItemBackgroundColor;
        _labNickname.font = [UIFont systemFontOfSize:12];
        _labNickname.textColor = TitleDarkColor;
        _labNickname.numberOfLines = 1;
        [self.contentView addSubview:_labNickname];
        [_labNickname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_imgAvatar);
            make.left.equalTo(_imgAvatar.mas_right).offset(7);
            make.right.lessThanOrEqualTo(self.contentView).offset(-20);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-10);
        }];
        
        _labLikeNum = [[UILabel alloc]init];
        //_labLikeNum.backgroundColor = ItemBackgroundColor;
        _labLikeNum.font = [UIFont systemFontOfSize:12];
        _labLikeNum.textColor = TitleLightColor;
        _labLikeNum.numberOfLines = 1;
        [self.contentView addSubview:_labLikeNum];
        [_labLikeNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_imgAvatar);
            make.right.equalTo(self.contentView).offset(-10);
            make.left.greaterThanOrEqualTo(_labNickname.mas_right).offset(10);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-10);
        }];
        
        _imgLike = [[UIImageView alloc]init];
        _imgLike.image = [UIImage imageNamed:@"btn_group_like_25x21_"];
        [self.contentView addSubview:_imgLike];
        [_imgLike mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_imgAvatar);
            make.right.equalTo(_labLikeNum.mas_left).offset(-7);
            make.height.width.equalTo(@12);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-10);
        }];
        
        _labContent = [[UILabel alloc]init];
        //_labContent.backgroundColor = ItemBackgroundColor;
        _labContent.textColor = TitleLightColor;
        _labContent.font = [UIFont systemFontOfSize:12];
        _labContent.numberOfLines = 2;
        [self.contentView addSubview:_labContent];
        [_labContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imgAvatar.mas_bottom).offset(12);
            make.left.equalTo(self.contentView).offset(10);
            make.right.lessThanOrEqualTo(self.contentView).offset(-10);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-10);
        }];
    }
    return self;
}

- (void)setCellInfoWithModal:(BTCategoryListModal *)modal {
    [_imgPic yy_setImageWithURL:[NSURL URLWithString:modal.middle_pic_url] options:YYWebImageOptionSetImageWithFadeAnimation];
    [_imgAvatar yy_setImageWithURL:[NSURL URLWithString:[modal.author validObjectForKey:@"avatar"]] options:YYWebImageOptionSetImageWithFadeAnimation];
    _labLikeNum.text = [modal.dynamic validObjectForKey:@"likes"];
    _labNickname.text = [modal.author validObjectForKey:@"nickname"];
    _labContent.text = modal.content;
}

@end




