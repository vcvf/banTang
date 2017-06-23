//
//  BTPlazaModal.h
//  BanTang
//
//  Created by guanli on 16/4/19.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTPlazaModal : NSObject

@property (nonatomic, retain)NSArray *banner;
@property (nonatomic, retain)NSArray *category_list;

- (id)initWithDictionary:(NSDictionary *)parameterDic;

+ (id)modalWithDictionary:(NSDictionary *)parameterDic;

@end
