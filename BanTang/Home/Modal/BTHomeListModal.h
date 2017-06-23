//
//  BTHomeListModal.h
//  BanTang
//
//  Created by guanli on 16/4/18.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTHomeListModal : NSObject

@property (nonatomic, copy)NSString *id_;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *pic;
@property (nonatomic, copy)NSString *is_show_like;
@property (nonatomic, copy)NSString *islike;
@property (nonatomic, copy)NSString *likes;
@property (nonatomic, copy)NSString *update_time;
@property (nonatomic, retain)NSDictionary *user;

- (id)initWithDictionary:(NSDictionary *)parameterDic;

+ (id)modalWithDictionary:(NSDictionary *)parameterDic;

+ (NSArray *)arrayModalWithArray:(NSArray *)parameterArray;

@end
