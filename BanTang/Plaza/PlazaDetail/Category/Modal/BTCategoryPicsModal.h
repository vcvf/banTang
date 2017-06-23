//
//  BTCategoryPicsModal.h
//  BanTang
//
//  Created by guanli on 16/4/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTCategoryPicsModal : NSObject

@property (nonatomic, copy)NSString *url;
@property (nonatomic, retain)NSArray *tags;
@property (nonatomic, copy)NSString *width;
@property (nonatomic, copy)NSArray *height;

- (id)initWithDictionary:(NSDictionary *)parameterDic;

+ (id)modalWithDictionary:(NSDictionary *)parameterDic;

+ (NSArray *)arrayModalWithArray:(NSArray *)parameterArray;

@end
