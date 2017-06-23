//
//  UIImage+Extension.h
//  BanTang
//
//  Created by guanli on 16/4/21.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

//图片虚化
-(UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

@end
