//
//  BTHomeBannerModal.h
//  BanTang
//
//  Created by guanli on 16/4/1.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTHomeBannerModal : NSObject

@property (nonatomic, copy)NSString *id_;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *sub_title;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *topic_type;
@property (nonatomic, copy)NSString *photo;
@property (nonatomic, copy)NSString *extend;
@property (nonatomic, copy)NSString *index;

- (id)initWithDictionary:(NSDictionary *)parameterDic;

+ (id)modalWithDictionary:(NSDictionary *)parameterDic;

+ (NSArray *)arrayModalWithArray:(NSArray *)parameterArray;

@end
