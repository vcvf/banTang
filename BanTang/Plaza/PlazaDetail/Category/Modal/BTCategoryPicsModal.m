//
//  BTCategoryPicsModal.m
//  BanTang
//
//  Created by guanli on 16/4/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTCategoryPicsModal.h"

@implementation BTCategoryPicsModal

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
        BTCategoryPicsModal *modal = [self modalWithDictionary:dic];
        [array addObject:modal];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
