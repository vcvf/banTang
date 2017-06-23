//
//  MyLog.h
//  MyLog
//
//  Created by 韦德 on 15/5/19.
//  Copyright © 2015年 韦德. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//#ifdef DEBUG
//#define NSLog(format, ...) ([MyLog output:__FILE__ lineNumber:__LINE__ input:(format), ## __VA_ARGS__])
//#else
//#define NSLog(format, ...)›
//#endif

@interface MyLog : NSObject

+ (void)output:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input, ...;

@end
