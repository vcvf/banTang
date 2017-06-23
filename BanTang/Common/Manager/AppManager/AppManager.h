//
//  AppManager.h
//  BanTang
//
//  Created by guanli on 16/5/30.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppManager : NSObject

+ (BOOL)isLogin;

+ (void)loginWithBlock:(void(^)(id result,NSError *error))block;

@end
