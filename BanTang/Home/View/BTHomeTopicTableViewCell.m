//
//  BTHomeTopicTableViewCell.m
//  BanTang
//
//  Created by guanli on 16/4/18.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTHomeTopicTableViewCell.h"

#define IMAGEHEIGHT (ScreenWidth * 0.53)

@implementation BTHomeTopicTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _imgV = [[UIImageView alloc]init];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV.clipsToBounds = YES;
        _imgV.backgroundColor = ItemBackgroundColor;
        [self.contentView addSubview:_imgV];
        
        _labTitle = [[UILabel alloc]init];
        //_labTitle.backgroundColor = [UIColor redColor];
        _labTitle.font = [UIFont systemFontOfSize:16];
        _labTitle.textColor = [UIColor grayColor];
        _labTitle.numberOfLines = 1;
        [self.contentView addSubview:_labTitle];
        
        UIView *bottomView = [[UIView alloc]init];
        //bottomView.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:bottomView];
        
        _imgLike = [[UIImageView alloc]init];
        //_imgLike.backgroundColor = [UIColor redColor];
        _imgLike.image = [UIImage imageNamed:@"home_likes_icon"];
        [bottomView addSubview:_imgLike];
        
        _labLike = [[UILabel alloc]init];
        //_labLike.backgroundColor = [UIColor orangeColor];
        _labLike.font = [UIFont systemFontOfSize:13];
        _labLike.textColor = [UIColor lightGrayColor];
        _labLike.numberOfLines = 1;
        [bottomView addSubview:_labLike];
        
        [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(self.contentView);
            make.height.equalTo(@(IMAGEHEIGHT));
        }];
        
        [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(_imgV.mas_bottom).offset(10);
            make.left.greaterThanOrEqualTo(self.contentView).offset(20);
            make.right.lessThanOrEqualTo(self.contentView).offset(-20);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-10);
        }];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labTitle.mas_bottom).offset(10);
            make.centerX.equalTo(self.contentView);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-10);
        }];
        
        [_labLike mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(bottomView);
        }];
        
        [_imgLike mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.lessThanOrEqualTo(_labLike.mas_height).offset(-5);
            //make.width.equalTo(make.height);
            make.left.equalTo(bottomView);
            make.centerY.equalTo(_labLike.mas_centerY);
            make.right.equalTo(_labLike.mas_left).offset(-5);
        }];
    }
    return self;
}

- (void)setCellInfoWithModal:(BTHomeListModal *)modal {
    [_imgV yy_setImageWithURL:[NSURL URLWithString:modal.pic] options:YYWebImageOptionSetImageWithFadeAnimation];
    _labTitle.text = modal.title;
    _labLike.text = modal.likes;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
