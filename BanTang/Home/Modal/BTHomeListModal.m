//
//  BTHomeListModal.m
//  BanTang
//
//  Created by guanli on 16/4/18.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTHomeListModal.h"

@implementation BTHomeListModal

- (id)initWithDictionary:(NSDictionary *)parameterDic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:parameterDic];
    }
    return self;
}

+ (id)modalWithDictionary:(NSDictionary *)parameterDic {
    return [[super alloc]initWithDictionary:parameterDic];
}

+ (NSArray *)arrayModalWithArray:(NSArray *)parameterArray {
    NSMutableArray *arrayModal = [[NSMutableArray alloc]init];
    for (int i = 0;i < parameterArray.count;i ++) {
        NSDictionary *dic = [parameterArray validObjectForIndex:i];
        BTHomeListModal *modal = [self modalWithDictionary:dic];
        [arrayModal addObject:modal];
    }
    return arrayModal;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _id_ = value;
    }
}

@end
