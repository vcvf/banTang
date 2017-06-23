//
//  BTCategoryListBigCell.h
//  BanTang
//
//  Created by guanli on 16/4/23.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTCategoryListModal.h"

@protocol BTCategoryListBigCellDelegate <NSObject>

/**点击作者头像*/
- (void)onListBigCellAuthorAvatarButtonClickAuthorId:(NSString *)authorID;
/**点击评论按钮*/
- (void)onListBigCellCommentButtonClick;
/**点击喜欢按钮*/
- (void)onListBigCellLikeButtonClick;
/**分享按钮点击*/
- (void)onListBigCellShareButtonClick;
/**更多按钮点击*/
- (void)onListBigCellMoreButtonClick;
/**点击链接*/
- (void)onListBigCellLinkViewClick;
/**喜欢详情按钮点击*/
- (void)onListBigCellLikeDetailButtonClick;
/**评论详情按钮点击*/
- (void)onListBigCellCommentDetailButtonClick;

@end

@interface BTCategoryListBigCell : UICollectionViewCell

@property (nonatomic, assign)id<BTCategoryListBigCellDelegate> delegete;

@property (nonatomic, retain)UIButton *btnAvatar;
@property (nonatomic, retain)UILabel *labNickName;
@property (nonatomic, retain)UIImageView *imgHonour;
@property (nonatomic, retain)UILabel *labTime;
@property (nonatomic, retain)UIScrollView *scrollV;
@property (nonatomic, retain)UIPageControl *pageC;
@property (nonatomic, retain)UIButton *btnComment;
@property (nonatomic, retain)UIButton *btnLike;
@property (nonatomic, retain)UIButton *btnShare;
@property (nonatomic, retain)UIButton *btnMore;
@property (nonatomic, retain)UIView *viewTag;
@property (nonatomic, retain)UILabel *labContent;
@property (nonatomic, retain)UILabel *labLink;
@property (nonatomic, retain)UIView *viewLink;
@property (nonatomic, retain)UIButton *btnLikeNum;
@property (nonatomic, retain)UIButton *btnCommentNum;
@property (nonatomic, retain)UIView *commentView;
@property (nonatomic, retain)UIButton *btnUserAvatar;
@property (nonatomic, retain)UIControl *inputControl;

- (void)setCellInfoWithModal:(BTCategoryListModal *)listModal;

@end
