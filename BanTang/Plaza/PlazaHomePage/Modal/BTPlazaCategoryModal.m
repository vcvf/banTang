//
//  BTCategoryModal.m
//  BanTang
//
//  Created by guanli on 16/4/19.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPlazaCategoryModal.h"

@implementation BTPlazaCategoryModal

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
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0;i < parameterArray.count;i ++) {
        NSDictionary *dic = [parameterArray validObjectForIndex:i];
        BTPlazaCategoryModal *modal = [self modalWithDictionary:dic];
        [array addObject:modal];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _id_ = value;
    }
}


@end
