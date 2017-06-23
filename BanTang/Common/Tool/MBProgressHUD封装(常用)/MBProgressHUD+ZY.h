//
//  MBProgressHUD+ZY.h
//  YiChatClient
//
//  Created by 张泽楠 on 15/10/28.
//  Copyright © 2015年 ds. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (ZY)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
@end