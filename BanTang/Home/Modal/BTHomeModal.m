//
//  BTHomeModal.m
//  BanTang
//
//  Created by guanli on 16/4/1.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTHomeModal.h"
#import "BTHomeBannerModal.h"
#import "BTHomeCategoryModal.h"
#import "BTHomeListModal.h"

@implementation BTHomeModal

- (id)initWithDictionary:(NSDictionary *)parameterDic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:parameterDic];
    }
    return self;
}

+ (id)modalWithDictionary:(NSDictionary *)parameterDic {
    return [[super alloc]initWithDictionary:parameterDic];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

#pragma mark - SetMethod

- (void)setBanner:(NSArray *)banner {
    NSArray *bannerModalArray = [BTHomeBannerModal arrayModalWithArray:banner];
    _banner = bannerModalArray;
}

- (void)setCategory_element:(NSArray *)category_element {
    NSArray *categoryArray = [BTHomeCategoryModal arrayModalWithArray:category_element];
    _category_element = categoryArray;
}

- (void)setTopic:(NSArray *)topic {
    NSArray *topicArray = [BTHomeListModal arrayModalWithArray:topic];
    _topic = topicArray;
}

@end
