//
//  BTHomeNetWorkRequest.m
//  BanTang
//
//  Created by guanli on 16/4/1.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTHomeNetWorkRequest.h"
#import "BTHomeModal.h"

@interface BTHomeNetWorkRequest ()

@property (nonatomic, retain)AFHTTPSessionManager *httpManager;

@end

@implementation BTHomeNetWorkRequest

static BTHomeNetWorkRequest *_homeNetworkRequest;

//请求单例
+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _homeNetworkRequest = [[BTHomeNetWorkRequest alloc]init];
    });
    return _homeNetworkRequest;
}

//AF请求对象
- (AFHTTPSessionManager *)httpManager {
    if (!_httpManager) {
        _httpManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@""]];
    }
    return _httpManager;
}

- (void)getHomeRecommendDataWithDictionary:(NSDictionary *)parameterDic success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    [self.httpManager POST:@"http://open3.bantangapp.com/recommend/index" parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"%@",responseObject);
        if (responseObject) {
            NSDictionary *dicData = [responseObject validObjectForKey:@"data"];
            BTHomeModal *homeModal = [BTHomeModal modalWithDictionary:dicData];
            if (successBlock) {
                successBlock(homeModal);
            }
        } 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败:%@",error.localizedDescription);
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

- (void)getHomeTopicListDataWithDictionary:(NSDictionary *)parameterDic success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    [self.httpManager POST:@"http://open3.bantangapp.com/topic/list" parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSDictionary *dicData = [responseObject validObjectForKey:@"data"];
            BTHomeModal *homeModal = [BTHomeModal modalWithDictionary:dicData];
            if (successBlock) {
                successBlock(homeModal);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败:%@",error.localizedDescription);
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
