//
//  BTPlazaModal.m
//  BanTang
//
//  Created by guanli on 16/4/19.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPlazaModal.h"
#import "BTPlazaBannerModal.h"
#import "BTPlazaCategoryModal.h"

@implementation BTPlazaModal

- (id)initWithDictionary:(NSDictionary *)parameterDic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:parameterDic];
    }
    return self;
}

+ (id)modalWithDictionary:(NSDictionary *)parameterDic {
    return [[self alloc]initWithDictionary:parameterDic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (void)setBanner:(NSArray *)banner {
    NSArray *bannerModalArray = [BTPlazaBannerModal arrayModalWithArray:banner];
    _banner = bannerModalArray;
}

- (void)setCategory_list:(NSArray *)category_list {
    NSArray *categoryModalArray = [BTPlazaCategoryModal arrayModalWithArray:category_list];
    _category_list = categoryModalArray;
}

@end
