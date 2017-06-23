//
//  BTHomeNetWorkRequest.h
//  BanTang
//
//  Created by guanli on 16/4/1.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id obj);
typedef void(^FailureBlock)(id obj);

@interface BTHomeNetWorkRequest : NSObject

//请求单例
+ (id)sharedInstance;

//获取"最新"列表数据
- (void)getHomeRecommendDataWithDictionary:(NSDictionary *)parameterDic success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

//获取各个主题列表数据
- (void)getHomeTopicListDataWithDictionary:(NSDictionary *)parameterDic success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;

@end
