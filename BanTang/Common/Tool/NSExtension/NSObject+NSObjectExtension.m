//
//  NSObject+NSObjectExtension.m
//  BanTang
//
//  Created by guanli on 16/3/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "NSObject+NSObjectExtension.h"

@implementation NSObject (NSObjectExtension)

@end

@implementation NSDictionary (NSDictionaryExtension)

- (id)validObjectForKey:(id)key {
    if (key == nil) {
        return nil;
    }
    
    if (![self isKindOfClass:[NSDictionary class]]) {
        return self;
    }
    
    if (self.count == 0) {
        return nil;
    }
    
    NSObject *object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    return object;
}

@end

@implementation NSArray (NSArrayExtension)

- (id)validObjectForIndex:(NSInteger)index {
    
    if (index >= self.count) {
        return nil;
    }
    
    NSObject *object = [self objectAtIndex:index];
    if ([object isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    return object;
}

@end

@implementation NSString (NSStringExtension)

- (NSString *)replaceUnicode:(NSString *)unicodeStr {
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [ NSPropertyListSerialization  propertyListFromData:tempData
                                                             mutabilityOption:NSPropertyListImmutable
                                                                       format:NULL
                                                             errorDescription:NULL];
    
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

@end

@implementation NSDate (NSDateExtension)

+ (NSString *)unixDateString {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%d", (int)a];
    return timeString;
}

@end
