//
//  BTHomeMainScrollView.m
//  BanTang
//
//  Created by guanli on 16/5/23.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTHomeMainScrollView.h"

@implementation BTHomeMainScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
