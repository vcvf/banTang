//
//  BTCategoryListBigCell.m
//  BanTang
//
//  Created by guanli on 16/4/23.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTCategoryListBigCell.h"
#import "BTCategoryPicsModal.h"
#import "BTCategoryTagsModal.h"
#import "BTCategoryCommentsModal.h"
#import "BTCategoryProductModal.h"

@interface BTCategoryListBigCell () <UIScrollViewDelegate> {
    UIImageView *_imgVlineOne;
    UIImageView *_imgVlineTwo;
    BTCategoryListModal *_localListModal;
}

@end

@implementation BTCategoryListBigCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        _btnAvatar = [UIButton buttonWithType:UIButtonTypeSystem];
        _btnAvatar.backgroundColor = ItemBackgroundColor;
        [_btnAvatar addTarget:self action:@selector(onBtnAvatarButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnAvatar];
        
        _labNickName = [[UILabel alloc]init];
        //_labNickName.backgroundColor = ItemBackgroundColor;
        _labNickName.textColor = TitleDarkColor;
        _labNickName.font = [UIFont systemFontOfSize:14];
        _labNickName.numberOfLines = 1;
        [self.contentView addSubview:_labNickName];
        
        _imgHonour = [[UIImageView alloc]init];
        _imgHonour.image = [UIImage imageNamed:@"community_good_stamps"];
        [self.contentView addSubview:_imgHonour];
        
        _labTime = [[UILabel alloc]init];
        _labTime.textColor = TitleLightColor;
        _labTime.font = [UIFont systemFontOfSize:13];
        _labTime.numberOfLines = 1;
        [self.contentView addSubview:_labTime];
        
        _scrollV = [[UIScrollView alloc]init];
        _scrollV.pagingEnabled = YES;
        _scrollV.bounces = NO;
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.backgroundColor = ItemBackgroundColor;
        _scrollV.delegate = self;
        [self.contentView addSubview:_scrollV];
        
        _pageC = [[UIPageControl alloc]init];
        _pageC.currentPage = 0;
        _pageC.userInteractionEnabled = NO;
        _pageC.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageC.pageIndicatorTintColor = ItemBackgroundColor;
        [self.contentView addSubview:_pageC];
        
        _btnComment = [UIButton buttonWithType:UIButtonTypeCustom];
        //_btnComment.backgroundColor = ItemBackgroundColor;
        [_btnComment setImage:[UIImage imageNamed:@"btn_group_comment_23x23_"] forState:UIControlStateNormal];
        [_btnComment setImage:[UIImage imageNamed:@"btn_group_comment_dark_23x23_"] forState:UIControlStateHighlighted];
        [_btnComment addTarget:self action:@selector(onCommentBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnComment];
        
        _btnLike = [UIButton buttonWithType:UIButtonTypeCustom];
        //_btnLike.backgroundColor = ItemBackgroundColor;
        [_btnLike setImage:[UIImage imageNamed:@"btn_group_like_25x21_"] forState:UIControlStateNormal];
        [_btnLike setImage:[UIImage imageNamed:@"btn_group_like_dark_25x21_"] forState:UIControlStateHighlighted];
        [_btnLike addTarget:self action:@selector(onLikeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnLike];
        
        _btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
        //_btnShare.backgroundColor = ItemBackgroundColor;
        [_btnShare setImage:[UIImage imageNamed:@"btn_group_share_28x21_"] forState:UIControlStateNormal];
        [_btnShare setImage:[UIImage imageNamed:@"btn_group_share_dark_28x21_"] forState:UIControlStateHighlighted];
        [_btnShare addTarget:self action:@selector(onShareBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnShare];
        
        _btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
        //_btnMore.backgroundColor = ItemBackgroundColor;
        [_btnMore setImage:[UIImage imageNamed:@"btn_group_more_24x4_"] forState:UIControlStateNormal];
        [_btnMore setImage:[UIImage imageNamed:@"btn_group_more_dark_24x4_"] forState:UIControlStateHighlighted];
        [_btnMore addTarget:self action:@selector(onMoreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnMore];
        
        _imgVlineOne = [[UIImageView alloc]init];
        //_imgVlineOne.backgroundColor = ItemBackgroundColor;
        _imgVlineOne.image = [UIImage imageNamed:@"line_group_post_comment_353x0_"];
        [self.contentView addSubview:_imgVlineOne];
        
        _viewTag = [[UIView alloc]init];
        //_viewTag.backgroundColor = ItemBackgroundColor;
        [self.contentView addSubview:_viewTag];
        
        UIImageView *imgVTag = [[UIImageView alloc]init];
        imgVTag.image = [UIImage imageNamed:@"community_tag"];
        [_viewTag addSubview:imgVTag];
        
        _labContent = [[UILabel alloc]init];
        //_labContent.backgroundColor = ItemBackgroundColor;
        _labContent.font = [UIFont systemFontOfSize:13];
        _labContent.textColor = TitleDarkColor;
        _labContent.numberOfLines = 0;
        [self.contentView addSubview:_labContent];
        
        _labLink = [[UILabel alloc]init];
        //_labLink.backgroundColor = ItemBackgroundColor;
        _labLink.textColor = TitleDarkColor;
        _labLink.font = [UIFont systemFontOfSize:12];
        _labLink.text = @"相关链接";
        [self.contentView addSubview:_labLink];
        
        _viewLink = [[UIView alloc]init];
        _viewLink.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        [self.contentView addSubview:_viewLink];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onLinkViewClick)];
        [_viewLink addGestureRecognizer:tapGes];
        
        _btnLikeNum = [UIButton buttonWithType:UIButtonTypeSystem];
        //_btnLikeNum.backgroundColor = ItemBackgroundColor;
        _btnLikeNum.titleLabel.font = [UIFont systemFontOfSize:12];
        [_btnLikeNum setImage:[[UIImage imageNamed:@"community_like"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_btnLikeNum setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -10)];
        [_btnLikeNum setTitleColor:TitleLightColor forState:UIControlStateNormal];
        [_btnLikeNum addTarget:self action:@selector(onLikeDetailBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnLikeNum];
        
        _btnCommentNum = [UIButton buttonWithType:UIButtonTypeSystem];
        //_btnCommentNum.backgroundColor = ItemBackgroundColor;
        //[_btnCommentNum setTitle:@"评论" forState:UIControlStateNormal];
        [_btnCommentNum setTitleColor:TitleLightColor forState:UIControlStateNormal];
        _btnCommentNum.titleLabel.font = [UIFont systemFontOfSize:12];
        [_btnCommentNum addTarget:self action:@selector(onCommentDetailBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnCommentNum];
        
        _commentView = [[UIView alloc]init];
        //_commentView.backgroundColor = ItemBackgroundColor;
        [self.contentView addSubview:_commentView];
        
        _imgVlineTwo = [[UIImageView alloc]init];
        //_imgVlineTwo.backgroundColor = ItemBackgroundColor;
        _imgVlineTwo.image = [UIImage imageNamed:@"line_group_post_comment_353x0_"];
        [self.contentView addSubview:_imgVlineTwo];
        
        _btnUserAvatar = [[UIButton alloc]init];
        _btnUserAvatar.backgroundColor = ItemBackgroundColor;
        [_btnUserAvatar setImage:[UIImage imageNamed:@"default_icon_placehodler"] forState:UIControlStateNormal];
        [self.contentView addSubview:_btnUserAvatar];
        
        _inputControl = [[UIControl alloc]init];
        [_inputControl addTarget:self action:@selector(onCommentBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_inputControl];
        
        UIImageView *imgVInput = [[UIImageView alloc]init];
        UIImage *imageInput = [[UIImage imageNamed:@"community_commnetinput_bg"] stretchableImageWithLeftCapWidth:37/2.0 topCapHeight:0];
        imgVInput.image = imageInput;
        [_inputControl addSubview:imgVInput];
        
        UILabel *labplaceholder = [[UILabel alloc]init];
        labplaceholder.font = [UIFont systemFontOfSize:14];
        labplaceholder.textColor = TitleLightColor;
        labplaceholder.text = @"我来说两句";
        [_inputControl addSubview:labplaceholder];
        
        [_btnAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(self.contentView).offset(10);
            make.height.width.equalTo(@35);
        }];
        
        [_labNickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_btnAvatar);
            make.left.equalTo(_btnAvatar.mas_right).offset(10);
            make.right.lessThanOrEqualTo(self.contentView);
        }];
        
        [_imgHonour mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_btnAvatar);
            make.height.width.equalTo(@15);
            make.left.equalTo(_labNickName.mas_right).offset(10);
        }];
        
        [_labTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_btnAvatar);
            make.right.equalTo(self.contentView).offset(-10);
            make.left.greaterThanOrEqualTo(_imgHonour.mas_right).offset(10);
        }];
        
        [_scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_btnAvatar.mas_bottom).offset(10);
            make.centerX.equalTo(self.contentView);
            make.width.height.equalTo(@(ScreenWidth));
        }];
        
        for (int i = 0;i < 5;i ++) {
            UIImageView *imgVPics = [[UIImageView alloc]init];
            imgVPics.contentMode = UIViewContentModeScaleAspectFill;
            imgVPics.layer.masksToBounds = YES;
            imgVPics.tag = i + 1;
            imgVPics.frame = CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenWidth);
            [self.scrollV addSubview:imgVPics];
        }
        self.scrollV.contentSize = CGSizeMake(ScreenWidth * 5, ScreenWidth);
        
        [_pageC mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_scrollV.mas_bottom).offset(0);
            make.right.left.equalTo(self.contentView);
            make.height.equalTo(@15);
        }];
        
        [_btnComment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollV.mas_bottom).offset(13);
            make.left.equalTo(self.contentView).offset(13);
            make.width.height.equalTo(@23);
        }];
        
        [_btnLike mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollV.mas_bottom).offset(13);
            make.left.equalTo(_btnComment.mas_right).offset(20);
            make.width.height.equalTo(@23);
        }];
        
        [_btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollV.mas_bottom).offset(13);
            make.left.equalTo(_btnLike.mas_right).offset(20);
            make.width.height.equalTo(@23);
        }];
        
        [_btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_scrollV.mas_bottom).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.width.height.equalTo(@23);
        }];
        
        [_imgVlineOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_btnMore.mas_bottom).offset(13);
            make.right.equalTo(self.contentView).offset(-10);
            make.left.equalTo(self.contentView).offset(10);
            make.height.equalTo(@1.0);
        }];

        [_viewTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imgVlineOne.mas_bottom).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.left.equalTo(self.contentView).offset(10);
            make.height.equalTo(@15);
        }];
        
        [imgVTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_viewTag);
            make.top.equalTo(_viewTag);
            make.bottom.equalTo(_viewTag);
            make.width.equalTo(@13);
        }];
        
        [_labContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_viewTag.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
        [_labLink mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labContent.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(10);
            make.right.lessThanOrEqualTo(self.contentView).offset(-10);
        }];
        
        [_viewLink mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labLink.mas_bottom).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.left.equalTo(self.contentView).offset(10);
            make.height.equalTo(@65);
        }];
        
        CGSize size = [@"评论喜欢" sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}];
        [_btnLikeNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_viewLink.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(10);
            make.right.lessThanOrEqualTo(self.contentView).offset(-10);
        }];
        
        [_btnCommentNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_btnLikeNum.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(10);
            make.right.lessThanOrEqualTo(self.contentView).offset(-10);
            make.height.equalTo(@(size.height));
        }];
        
        [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_btnCommentNum.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
        [_imgVlineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_commentView.mas_bottom).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.left.equalTo(self.contentView).offset(10);
            make.height.equalTo(@1.0);
        }];
        
        [_btnUserAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imgVlineTwo.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset(10);
            make.width.height.equalTo(@30);
            make.bottom.lessThanOrEqualTo(self.contentView).offset(-10).priority(750);
        }];
        
        [_inputControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_btnUserAvatar);
            make.left.equalTo(_btnUserAvatar.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(_btnUserAvatar);
        }];
        
        [imgVInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
        
        [labplaceholder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.equalTo(_inputControl);
            make.left.equalTo(@20);
        }];
        
    }
    return self;
}

- (void)test {
    NSLog(@"hello");
}

- (void)setCellInfoWithModal:(BTCategoryListModal *)listModal {
    //cell本地模型赋值
    _localListModal = listModal;
    
    [_btnAvatar yy_setBackgroundImageWithURL:[NSURL URLWithString:[listModal.author validObjectForKey:@"avatar"]] forState:UIControlStateNormal options:YYWebImageOptionSetImageWithFadeAnimation];
    _labNickName.text = [listModal.author validObjectForKey:@"nickname"];
    _labTime.text = listModal.datestr;
    if ([listModal.is_recommend isEqualToString:@"1"]) {
        //设置推荐用户图标
        _imgHonour.hidden = NO;
    } else {
        _imgHonour.hidden = YES;
    }
    
    //设置ScrollView上面的picture
    NSArray *picsModalAarray = listModal.pics;
    for (int i = 0; i < picsModalAarray.count; i ++) {
        BTCategoryPicsModal *picsModal = [picsModalAarray validObjectForIndex:i];
        UIImageView *imgVPics = [self.scrollV viewWithTag:i + 1];
        
        [imgVPics yy_setImageWithURL:[NSURL URLWithString:picsModal.url] options:YYWebImageOptionSetImageWithFadeAnimation];
    }
    self.scrollV.contentSize = CGSizeMake(ScreenWidth * picsModalAarray.count, ScreenWidth);
    //设置pageController属性
    if (picsModalAarray.count == 1) {
        self.pageC.hidden = YES;
    } else {
        self.pageC.hidden = NO;
    }
    self.pageC.numberOfPages = picsModalAarray.count;
    
    //设置标签
    for (UIView *view in self.viewTag.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    if (listModal.tags.count != 0) {
        [self.viewTag mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imgVlineOne.mas_bottom).offset(10);
            make.height.equalTo(@15);
        }];
    } else {
        [self.viewTag mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imgVlineOne.mas_bottom).offset(0);
            make.height.equalTo(@0);
        }];
    }
    
    UIButton *tempBTnTag = nil;
    for (int i = 0;i < listModal.tags.count;i ++) {
        BTCategoryTagsModal *tagsModal = [listModal.tags validObjectForIndex:i];
        UIButton *btnTag = [UIButton buttonWithType:UIButtonTypeSystem];
        btnTag.titleLabel.font = [UIFont systemFontOfSize:12];
        [btnTag setTitle:tagsModal.name forState:UIControlStateNormal];
        [btnTag setTitleColor:TopicColor forState:UIControlStateNormal];
        [self.viewTag addSubview:btnTag];
        [btnTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_viewTag);
            if (tempBTnTag == nil) {
                make.left.equalTo(@20);
            } else {
                make.left.equalTo(tempBTnTag.mas_right).offset(10);
            }
            make.right.lessThanOrEqualTo(self.viewTag);
        }];
        tempBTnTag = btnTag;
    }
    
    //设置content内容
    self.labContent.text = listModal.content;
    
    //设置链接
    NSArray *productModalArray = listModal.product;
    BTCategoryProductModal *produceModal = [productModalArray validObjectForIndex:0];
    for (UIView *view in self.viewLink.subviews) {
        [view removeFromSuperview];
    }
    if (productModalArray.count == 0) {
        self.labLink.text = @"";
        [self.labLink mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labContent.mas_bottom).offset(0);
        }];
        [self.viewLink mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labLink.mas_bottom).offset(0);
            make.height.equalTo(@0);
        }];
    } else {
        self.labLink.text = @"相关链接";
        [self.labLink mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labContent.mas_bottom).offset(10);
        }];
        [self.viewLink mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_labLink.mas_bottom).offset(10);
            make.height.equalTo(@65);
        }];
                UIImageView *imgVLinkPic = [[UIImageView alloc]init];
                imgVLinkPic.backgroundColor = ItemBackgroundColor;
                [self.viewLink addSubview:imgVLinkPic];
                [imgVLinkPic yy_setImageWithURL:[NSURL URLWithString:produceModal.pic] options:YYWebImageOptionSetImageWithFadeAnimation];
                [imgVLinkPic mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.bottom.equalTo(self.viewLink);
                    make.width.equalTo(@65);
                }];
        
                UILabel *labTitle = [[UILabel alloc]init];
                labTitle.font = [UIFont systemFontOfSize:13];
                labTitle.textColor = TitleDarkColor;
                labTitle.text = produceModal.title;
                [self.viewLink addSubview:labTitle];
                [labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_viewLink).offset(12);
                    make.left.equalTo(imgVLinkPic.mas_right).offset(10);
                    make.right.lessThanOrEqualTo(_viewLink);
                    make.bottom.lessThanOrEqualTo(_viewLink);
                }];
        
                UIImageView *imgVLinkPlatform = [[UIImageView alloc]init];
                [self.viewLink addSubview:imgVLinkPlatform];
                [imgVLinkPlatform mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imgVLinkPic.mas_right).offset(10);
                    make.bottom.equalTo(_viewLink).offset(-12);
                    make.top.equalTo(labTitle.mas_bottom).offset(10);
                    make.width.equalTo(@15);
                }];
        
                UILabel *labPlatform = [[UILabel alloc]init];
                labPlatform.textColor = TitleLightColor;
                labPlatform.font = [UIFont systemFontOfSize:12];
                [self.viewLink addSubview:labPlatform];
                [labPlatform mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(imgVLinkPlatform);
                    make.left.equalTo(imgVLinkPlatform.mas_right).offset(10);
                    make.right.lessThanOrEqualTo(_viewLink);
                }];
        
                UILabel *labPrice = [[UILabel alloc]init];
                labPrice.textColor = TopicColor;
                labPrice.font = [UIFont systemFontOfSize:12];
                labPrice.text = [NSString stringWithFormat:@"¥%@",produceModal.price];
                [self.viewLink addSubview:labPrice];
                [labPrice mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(labPlatform);
                    make.left.equalTo(labPlatform.mas_right).offset(10);
                    make.right.lessThanOrEqualTo(_viewLink);
                }];
        
                NSString *tempStr = produceModal.url;
                if ([tempStr containsString:@"taobao"]) {
                    imgVLinkPlatform.image = [UIImage imageNamed:@"community_taobao"];
                    labPlatform.text = @"来自淘宝";
                } else if ([tempStr containsString:@"tmall"]) {
                    imgVLinkPlatform.image = [UIImage imageNamed:@"community_tianmao"];
                    labPlatform.text = @"来自天猫";
                } else if ([tempStr containsString:@"jd"]) {
                    imgVLinkPlatform.image = [UIImage imageNamed:@"community_jingdong"];
                    labPlatform.text = @"来自京东";
                }
    }
    
    //设置评论数量与喜欢数量按钮
    [self.btnLikeNum setTitle:[NSString stringWithFormat:@"%@人喜欢",[listModal.dynamic validObjectForKey:@"likes"]] forState:UIControlStateNormal];
    
    if ([[listModal.dynamic validObjectForKey:@"comments"] isEqualToString:@"0"] || [[listModal.dynamic validObjectForKey:@"comments"] intValue] == 0) {
        [self.btnCommentNum setTitle:@"评论" forState:UIControlStateNormal];
    } else {
        [self.btnCommentNum setTitle:[NSString stringWithFormat:@"所有%@条评论",[listModal.dynamic validObjectForKey:@"comments"]] forState:UIControlStateNormal];
    }
    

    
    //设置评论内容
    NSArray *commentModalArray = listModal.comments;
    for (UILabel *labComment in self.commentView.subviews) {
        [labComment removeFromSuperview];
    }
    
    if (commentModalArray.count == 0) {
        [self.commentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_btnCommentNum.mas_bottom).offset(0);
        }];
    } else {
        [self.commentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_btnCommentNum.mas_bottom).offset(10);
        }];
    }
    
    UILabel *tempLabComment = nil;
    for (int i = 0;i < commentModalArray.count;i ++) {
        BTCategoryCommentsModal *commentModal = [commentModalArray validObjectForIndex:i];
        UILabel *labComment = [[UILabel alloc]init];
        //labComment.backgroundColor = [UIColor yellowColor];
        labComment.numberOfLines = 0;
        labComment.textColor = TitleDarkColor;
        labComment.font = [UIFont systemFontOfSize:13];
        [self.commentView addSubview:labComment];
        [labComment mas_makeConstraints:^(MASConstraintMaker *make) {
            if (tempLabComment == nil) {
                make.top.equalTo(self.commentView);
            } else {
                make.top.equalTo(tempLabComment.mas_bottom).offset(5);
            }
            make.left.right.equalTo(self.commentView);
            make.bottom.lessThanOrEqualTo(self.commentView);
        }];
        if ([[commentModal.at_user validObjectForKey:@"nickname"] length] != 0) {
            labComment.text = [NSString stringWithFormat:@"%@: 回复@%@ %@",commentModal.nickname,[commentModal.at_user validObjectForKey:@"nickname"],commentModal.conent];
        } else {
            labComment.text = [NSString stringWithFormat:@"%@: %@",commentModal.nickname,commentModal.conent];
        }
        tempLabComment = labComment;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageC.currentPage = scrollView.contentOffset.x / ScreenWidth;
}

#pragma mark - Click_Event_Delegate

/**作者头像点击*/
- (void)onBtnAvatarButtonClick {
    if ([_delegete respondsToSelector:@selector(onListBigCellAuthorAvatarButtonClickAuthorId:)]) {
        [_delegete onListBigCellAuthorAvatarButtonClickAuthorId:_localListModal.author_id];
    }
}

/**评论按钮点击*/
- (void)onCommentBtnClick {
    if ([_delegete respondsToSelector:@selector(onListBigCellCommentButtonClick)]) {
        [_delegete onListBigCellCommentButtonClick];
    }
}

/**喜欢按钮点击*/
- (void)onLikeBtnClick {
    if ([_delegete respondsToSelector:@selector(onListBigCellLikeButtonClick)]) {
        [_delegete onListBigCellLikeButtonClick];
    }
}

/**分享按钮点击*/
- (void)onShareBtnClick {
    if ([_delegete respondsToSelector:@selector(onListBigCellShareButtonClick)]) {
        [_delegete onListBigCellShareButtonClick];
    }
}

/**跟多按钮点击*/
- (void)onMoreBtnClick {
    if ([_delegete respondsToSelector:@selector(onListBigCellMoreButtonClick)]) {
        [_delegete onListBigCellMoreButtonClick];
    }
}

/**链接view点击*/
- (void)onLinkViewClick {
    if ([_delegete respondsToSelector:@selector(onListBigCellLinkViewClick)]) {
        [_delegete onListBigCellLinkViewClick];
    }
}

/**喜欢详情按钮点击*/
- (void)onLikeDetailBtnClick {
    if ([_delegete respondsToSelector:@selector(onListBigCellLikeDetailButtonClick)]) {
        [_delegete onListBigCellLikeDetailButtonClick];
    }
}

/**评论详情按钮点击*/
- (void)onCommentDetailBtnClick {
    if ([_delegete respondsToSelector:@selector(onListBigCellCommentDetailButtonClick)]) {
        [_delegete onListBigCellCommentDetailButtonClick];
    }
}

@end
