//
//  BTPlazaBannerModal.m
//  BanTang
//
//  Created by guanli on 16/4/19.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPlazaBannerModal.h"

@implementation BTPlazaBannerModal

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
        BTPlazaBannerModal *modal = [self modalWithDictionary:dic];
        [array addObject:modal];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _id_ = value;
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"id:%@  title:%@  sub_title:%@  type:%@  photo:%@  extend:%@  index:%@",self.id_,self.title,self.sub_title,self.type,self.photo,self.extend,self.index];
}

@end
