//
//  HomePushTransitionAnimation.m
//  BanTang
//
//  Created by guanli on 16/5/23.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "HomePushTransitionAnimation.h"
#import "BTHomeVC.h"
#import "BTHomeDetailVC.h"
#import "BTHomeTopicTableViewCell.h"

@interface HomePushTransitionAnimation ()

@property (nonatomic,strong) id <UIViewControllerContextTransitioning>transitionContext;

@end

@implementation HomePushTransitionAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    UIView *containerView = [transitionContext containerView];
    BTHomeVC *homeVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    homeVC.tabBarController.tabBar.hidden = YES;
    BTHomeDetailVC *detailVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [containerView addSubview:detailVC.view];
    CGRect topViewFrame = detailVC.topImageView.frame;
    
    
    UITableView *tableView = homeVC.currentTableView;
    BTHomeTopicTableViewCell *homeCell = (BTHomeTopicTableViewCell *)[tableView cellForRowAtIndexPath:[tableView indexPathForSelectedRow]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:homeCell.imgV.image];
    
    CGRect frameInSuperview = [homeCell.imgV convertRect:homeCell.imgV.frame toView:homeVC.view];
    detailVC.topImgaeViewFrameInHomeView = frameInSuperview;
    imageView.alpha = 0.0;
    imageView.frame = frameInSuperview;
    [containerView addSubview:imageView];
    
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        imageView.frame = topViewFrame;
        imageView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        detailVC.topImageView.image = imageView.image;
        [imageView removeFromSuperview];
    }];
    
}

@end
