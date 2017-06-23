//
//  BTPlazaGrassModal.h
//  BanTang
//
//  Created by guanli on 16/5/6.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTPlazaGrassModal : NSObject

@property (nonatomic, copy)NSString *id_;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *pic1;
@property (nonatomic, copy)NSString *pic2;
@property (nonatomic, copy)NSString *pic3;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *update_time;
@property (nonatomic, retain)NSDictionary *author;
@property (nonatomic, retain)NSArray *attention_users;
@property (nonatomic, retain)NSDictionary *dynamic;
@property (nonatomic, copy)NSString *attention_type;
@property (nonatomic, copy)NSString *desc;

- (id)initWithDictionary:(NSDictionary *)parameterDic;

+ (id)modalWithDictionary:(NSDictionary *)parameterDic;

+ (NSArray *)arrayModalWithArray:(NSArray *)parameterArray;

@end
