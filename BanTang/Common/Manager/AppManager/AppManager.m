//
//  AppManager.m
//  BanTang
//
//  Created by guanli on 16/5/30.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "AppManager.h"
#import "LoginByThirdViewController.h"

@implementation AppManager

+ (BOOL)isLogin {
    return YES;
}

+ (void)loginWithBlock:(void(^)(id result,NSError *error))block {
    BOOL isLogin = [self isLogin];
    if (isLogin) {
        if (block) {
            block(nil,nil);
        }
    } else {
        if (block) {
            LoginByThirdViewController *loginVC = [[LoginByThirdViewController alloc] init];
        }
    }
}

@end
