//
//  UIColor+Hexadecimal.h
//  MaJia
//
//  Created by guanli on 16/3/5.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hexadecimal)

//把哈希数
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
