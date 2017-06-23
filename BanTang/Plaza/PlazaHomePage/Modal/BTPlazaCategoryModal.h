//
//  BTCategoryModal.h
//  BanTang
//
//  Created by guanli on 16/4/19.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTPlazaCategoryModal : NSObject

@property (nonatomic, copy)NSString *id_;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *en_name;
@property (nonatomic, copy)NSString *pic;

- (id)initWithDictionary:(NSDictionary *)parameterDic;

+ (id)modalWithDictionary:(NSDictionary *)parameterDic;

+ (NSArray *)arrayModalWithArray:(NSArray *)parameterArray;

@end
