//
//  BTDayTopicListModal.m
//  BanTang
//
//  Created by guanli on 16/4/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTCategoryListModal.h"
#import "BTCategoryTagsModal.h"
#import "BTCategoryPicsModal.h"
#import "BTCategoryProductModal.h"
#import "BTCategoryCommentsModal.h"

@implementation BTCategoryListModal

- (id)initWithDictionary:(NSDictionary *)parameterDic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:parameterDic];
    }
    return self;
}

+ (id)modalWithDictionary:(NSDictionary *)parameterDic {
    return [[self alloc]initWithDictionary:parameterDic];
}

+ (NSArray *)arrayModalWithArray:(NSArray *)parameterArray {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0;i < parameterArray.count;i ++) {
        NSDictionary *dic = [parameterArray validObjectForIndex:i];
        BTCategoryListModal *modal = [self modalWithDictionary:dic];
        [array addObject:modal];
    }
    return array;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _id_ = value;
    }
}

#pragma mark - SetMethod

- (void)setTags:(NSArray *)tags {
    NSArray *tagsModalArray = [BTCategoryTagsModal arrayModalWithArray:tags];
    _tags = tagsModalArray;
}

- (void)setPics:(NSArray *)pics {
    NSArray *picsModalArray = [BTCategoryPicsModal arrayModalWithArray:pics];
    _pics = picsModalArray;
}

- (void)setProduct:(NSArray *)product {
    NSArray *productModalArray = [BTCategoryProductModal arrayModalWithArray:product];
    _product = productModalArray;
}

- (void)setComments:(NSArray *)comments {
    NSArray *commentModalArray = [BTCategoryCommentsModal arrayModalWithArray:comments];
    _comments = commentModalArray;
}

@end
