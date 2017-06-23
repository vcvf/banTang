//
//  BTCategoryProductModal.h
//  BanTang
//
//  Created by guanli on 16/4/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTCategoryProductModal : NSObject

@property (nonatomic, copy)NSString *id_;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *price;
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *category_id;
@property (nonatomic, copy)NSString *item_id;
@property (nonatomic, copy)NSString *platform;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *pic;

- (id)initWithDictionary:(NSDictionary *)parameterDic;

+ (id)modalWithDictionary:(NSDictionary *)parameterDic;

+ (NSArray *)arrayModalWithArray:(NSArray *)parameterArray;

@end
