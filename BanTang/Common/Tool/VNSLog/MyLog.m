//
//  MyLog.m
//  MyLog
//
//  Created by 韦德on 15/5/19.
//  Copyright © 2015年 韦德. All rights reserved.
//

#import "MyLog.h"

@implementation MyLog
+ (void)output:(const char*)fileName
       lineNumber:(int)lineNumber
            input:(NSString*)input, ...{
    va_list argList;
    NSString *filePath, *formatStr;
    filePath = [[NSString alloc] initWithBytes:fileName
                                        length:strlen(fileName)
                                      encoding:NSUTF8StringEncoding];
    va_start(argList, input);
    formatStr = [[NSString alloc] initWithFormat:input
                                       arguments:argList];
    va_end(argList);
    
    printf("%s\n",[[NSString stringWithFormat:@"%@[%d] %@", [filePath lastPathComponent], lineNumber, formatStr] UTF8String]);
}
@end
