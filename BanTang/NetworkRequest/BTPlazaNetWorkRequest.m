//
//  BTPlazaNetWorkRequest.m
//  BanTang
//
//  Created by guanli on 16/4/19.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTPlazaNetWorkRequest.h"
#import "BTPlazaModal.h"
#import "BTPlazaRecommendModal.h"
#import "BTCategoryListModal.h"
#import "BTCategorySubclassModal.h"

#import "BTGoodsDetailModal.h"
#import "BTPlazaGrassModal.h"

@interface BTPlazaNetWorkRequest ()

@property (nonatomic, retain)AFHTTPSessionManager *httpManager;

@end

@implementation BTPlazaNetWorkRequest

static BTPlazaNetWorkRequest *_plazaNetWorkRequest;

//请求单例
+ (id)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _plazaNetWorkRequest = [[BTPlazaNetWorkRequest alloc]init];
    });
    return _plazaNetWorkRequest;
}

//AF请求对象
- (AFHTTPSessionManager *)httpManager {
    if (!_httpManager) {
        _httpManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@""]];
    }
    return _httpManager;
}


- (void)getPlazaBannerDataAndCategoryDataWithDictionary:(NSDictionary *)parameterDic success:(GetPlazaBannerSuccess)successBlock failure:(GetPlazaBannerFailure)failure {
    [self.httpManager POST:@"http://open3.bantangapp.com/community/post/index" parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            //NSLog(@"%@",responseObject);
            NSDictionary *dicData = [responseObject validObjectForKey:@"data"];
            BTPlazaModal *modal = [BTPlazaModal modalWithDictionary:dicData];
            if (successBlock) {
                successBlock(modal);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败:%@",error.localizedDescription);
    }];
}

- (void)getPlazaRecommendDataWithDictionary:(NSDictionary *)parameterDic success:(GetPlazaRecommendSuccess)successBlock failure:(GetPlazaRecommendFailure)failureBlock {
    [self.httpManager POST:@"http://open3.bantangapp.com/community/post/hotRecommend" parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            //NSLog(@"%@",responseObject);
            NSArray *arrayData = [responseObject validObjectForKey:@"data"];
            NSArray *arrayModal = [BTPlazaRecommendModal arrayModalWithArray:arrayData];
            if (successBlock) {
                successBlock(arrayModal);
            }
            //NSLog(@"%@",arrayModal);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败:%@",error.localizedDescription);
    }];
}

//- (void)getEverydayTopicDataWithDictionary:(NSDictionary *)parameterDic success:(GetEverydayTopicSuccess)successBlock failure:(GetEverydayTopicFailure)failureBlock {
//    [self.httpManager POST:@"http://open3.bantangapp.com/community/subject/info" parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (responseObject) {
//            //NSLog(@"%@",responseObject);
//            NSDictionary *dicData = [responseObject validObjectForKey:@"data"];
//            BTDayTopicHeadModal *headModal = [BTDayTopicHeadModal modalWithDictionary:dicData];
//            if (successBlock) {
//                successBlock(headModal);
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"失败:%@",error.localizedDescription);
//    }];
//}

//- (void)getEverydayTopicListDataWithDictionary:(NSDictionary *)parameterDic success:(GetEverydayTopicListSuccess)successBlock failure:(GetEverydayTopicListFailure)failureBlock {
//    [self.httpManager POST:@"http://open3.bantangapp.com/community/subject/listPost" parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (responseObject) {
//            //NSLog(@"%@",responseObject);
//            NSDictionary *dicData = [responseObject validObjectForKey:@"data"];
//            NSArray *listArray = [dicData validObjectForKey:@"list"];
//            NSArray *listModalArray = [BTCategoryListModal arrayModalWithArray:listArray];
//            //NSLog(@"%@",listModalArray);
//            if (successBlock) {
//                successBlock(listModalArray);
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"失败:%@",error.localizedDescription);
//    }];
//}

- (void)getCategoryDetailSubClassDataWithDictionary:(NSDictionary *)parameterDic success:(GetCategorySubclassSuccess)successBlock failure:(GetCategorySubclassFailure)failureBlock {
    [self.httpManager POST:@"http://open3.bantangapp.com/category/categoryInfo" parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            //NSLog(@"%@",responseObject);
            NSDictionary *dicData = [responseObject validObjectForKey:@"data"];
            NSArray *arraySubclass = [dicData validObjectForKey:@"subclass_list"];
            NSArray *categorySubClassModalArray = [BTCategorySubclassModal arrayModalWithArray:arraySubclass];
            if (successBlock) {
                successBlock(categorySubClassModalArray);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败:%@",error.localizedDescription);
    }];
}

- (void)getListDataByCategoryWithDictionary:(NSDictionary *)parameterDic success:(GetListByCategorySuccess)successBlock failure:(GetListByCategoryFailure)failureBlock {
    [self.httpManager POST:@"http://open3.bantangapp.com/community/post/listByCategory" parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            //NSLog(@"%@",responseObject);
            NSArray *arrayData = [responseObject validObjectForKey:@"data"];
            NSArray *listModalArray = [BTCategoryListModal arrayModalWithArray:arrayData];
            if (successBlock) {
                successBlock(listModalArray);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败:%@",error.localizedDescription);
    }];
}

- (void)getGoodsDetailDataWithDictionary:(NSDictionary *)parameterDic success:(GetListItemDetailDataSuccess)successBlock failure:(GetListItemDetailDataFailure)failureBlock {
    [self.httpManager POST:@"http://open3.bantangapp.com/community/post/info" parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            //NSLog(@"%@",responseObject);
            NSDictionary *dicData = [responseObject validObjectForKey:@"data"];
            NSDictionary *dicPost = [dicData validObjectForKey:@"post"];
            BTGoodsDetailModal *goodsDetailModal = [BTGoodsDetailModal modalWithDictionary:dicPost];
            if (successBlock) {
                successBlock(goodsDetailModal);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败:%@",error.localizedDescription);
    }];
}

- (void)getGrassListDataWithDictionary:(NSDictionary *)parameterDic success:(GetGrassListDataSuccess)successBlock failure:(GetGrassListDataFailure)failureBlock {
    [self.httpManager POST:@"http://open3.bantangapp.com/community/post/communityHome" parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            //NSLog(@"%@",responseObject);
            NSDictionary *dicData = [responseObject validObjectForKey:@"data"];
            NSArray *rec_groupsArray = [dicData validObjectForKey:@"rec_groups"];
            NSArray *grassModalArray = [BTPlazaGrassModal arrayModalWithArray:rec_groupsArray];
            if (successBlock) {
                successBlock(grassModalArray);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败:%@",error.localizedDescription);
    }];
}

@end
