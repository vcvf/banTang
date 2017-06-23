//
//  BTDayTopicListModal.h
//  BanTang
//
//  Created by guanli on 16/4/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTCategoryListModal : NSObject

@property (nonatomic, copy)NSString *id_;
@property (nonatomic, copy)NSString *content;
@property (nonatomic, copy)NSString *author_id;
@property (nonatomic, copy)NSString *relation_id;
@property (nonatomic, copy)NSString *share_url;
@property (nonatomic, copy)NSString *is_recommend;
@property (nonatomic, copy)NSString *create_time;
@property (nonatomic, copy)NSString *publish_time;
@property (nonatomic, copy)NSString *datetime;
@property (nonatomic, copy)NSString *datestr;
@property (nonatomic, copy)NSString *mini_pic_url;
@property (nonatomic, copy)NSString *middle_pic_url;
@property (nonatomic, retain)NSArray *tags;
@property (nonatomic, retain)NSDictionary *author;
@property (nonatomic, retain)NSArray *pics;
@property (nonatomic, retain)NSDictionary *dynamic;
@property (nonatomic, retain)NSArray *product;
@property (nonatomic, retain)NSArray *comments;

- (id)initWithDictionary:(NSDictionary *)parameterDic;

+ (id)modalWithDictionary:(NSDictionary *)parameterDic;

+ (NSArray *)arrayModalWithArray:(NSArray *)parameterArray;

@end
