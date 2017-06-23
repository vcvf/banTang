//
//  NSObject+NSObjectExtension.h
//  BanTang
//
//  Created by guanli on 16/3/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (NSObjectExtension)

@end

@interface NSDictionary (NSDictionaryExtension)

- (id)validObjectForKey:(id)key;

@end

@interface NSArray (NSArrayExtension)

- (id)validObjectForIndex:(NSInteger)index;

@end

@interface NSString (NSStringExtension)

//UniCode编码转中文
- (NSString *)replaceUnicode:(NSString *)unicodeStr;

@end

@interface NSDate (NSDateExtension)

+ (NSString *)unixDateString;

@end
