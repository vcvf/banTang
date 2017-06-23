//
//  BTHomeModal.h
//  BanTang
//
//  Created by guanli on 16/4/1.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTHomeModal : NSObject

@property (nonatomic, retain)NSArray *topic;//最新列表
@property (nonatomic, retain)NSArray *banner;//轮播图
@property (nonatomic, retain)NSArray *category_element;//分类
@property (nonatomic, retain)NSArray *banner_bottom_element;//轮播图下面分类按钮

- (id)initWithDictionary:(NSDictionary *)parameterDic;

+ (id)modalWithDictionary:(NSDictionary *)parameterDic;

@end
