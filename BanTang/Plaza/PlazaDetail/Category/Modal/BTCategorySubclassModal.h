//
//  BTCategorySubclassModal.h
//  BanTang
//
//  Created by guanli on 16/4/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTCategorySubclassModal : NSObject

@property (nonatomic, copy)NSString *id_;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *pic;

- (id)initWithDictionary:(NSDictionary *)parameterDic;

+ (id)modalWithDictionary:(NSDictionary *)parameterDic;

+ (NSArray *)arrayModalWithArray:(NSArray *)parameterArray;

@end
