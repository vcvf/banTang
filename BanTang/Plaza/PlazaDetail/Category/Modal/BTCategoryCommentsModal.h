//
//  BTDayTopicCommentsModal.h
//  BanTang
//
//  Created by guanli on 16/4/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTCategoryCommentsModal : NSObject

@property (nonatomic, copy)NSString *id_;
@property (nonatomic, copy)NSString *user_id;
@property (nonatomic, copy)NSString *username;
@property (nonatomic, copy)NSString *nickname;
@property (nonatomic, copy)NSString *avatar;
@property (nonatomic, copy)NSString *conent;
@property (nonatomic, copy)NSString *dateline;
@property (nonatomic, copy)NSString *datestr;
@property (nonatomic, copy)NSString *praise;
@property (nonatomic, copy)NSString *reply;
@property (nonatomic, copy)NSString *is_praise;
@property (nonatomic, copy)NSString *is_hot;
@property (nonatomic, retain)NSDictionary *at_user;
@property (nonatomic, retain)NSDictionary *product;
@property (nonatomic, copy)NSString *is_official;

- (id)initWithDictionary:(NSDictionary *)parameterDic;

+ (id)modalWithDictionary:(NSDictionary *)parameterDic;

+ (NSArray *)arrayModalWithArray:(NSArray *)parameterArray;

@end
