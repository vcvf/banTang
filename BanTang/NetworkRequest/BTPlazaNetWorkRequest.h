//
//  BTPlazaNetWorkRequest.h
//  BanTang
//
//  Created by guanli on 16/4/19.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GetPlazaBannerSuccess)(id obj);
typedef void(^GetPlazaBannerFailure)(id obj);

typedef void(^GetPlazaRecommendSuccess)(id obj);
typedef void(^GetPlazaRecommendFailure)(id obj);

typedef void(^GetEverydayTopicSuccess)(id obj);
typedef void(^GetEverydayTopicFailure)(id obj);

typedef void(^GetEverydayTopicListSuccess)(id obj);
typedef void(^GetEverydayTopicListFailure)(id obj);

typedef void(^GetCategorySubclassSuccess)(id obj);
typedef void(^GetCategorySubclassFailure)(id obj);

typedef void(^GetListByCategorySuccess)(id obj);
typedef void(^GetListByCategoryFailure)(id obj);

typedef void(^GetListItemDetailDataSuccess)(id obj);
typedef void(^GetListItemDetailDataFailure)(id obj);

typedef void(^GetGrassListDataSuccess)(id obj);
typedef void(^GetGrassListDataFailure)(id obj);

@interface BTPlazaNetWorkRequest : NSObject

/**请求单例*/
+ (id)sharedInstance;

/**获取banner与分类数据*/
- (void)getPlazaBannerDataAndCategoryDataWithDictionary:(NSDictionary *)parameterDic success:(GetPlazaBannerSuccess)successBlock failure:(GetPlazaBannerFailure)failure;

/**获取热门推荐的数据*/
- (void)getPlazaRecommendDataWithDictionary:(NSDictionary *)parameterDic success:(GetPlazaRecommendSuccess)successBlock failure:(GetPlazaRecommendFailure)failureBlock;

///**获取每日话题的数据*/
//- (void)getEverydayTopicDataWithDictionary:(NSDictionary *)parameterDic success:(GetEverydayTopicSuccess)successBlock failure:(GetEverydayTopicFailure)failureBlock;
//
///**获取每日话题列表数据*/
//- (void)getEverydayTopicListDataWithDictionary:(NSDictionary *)parameterDic success:(GetEverydayTopicListSuccess)successBlock failure:(GetEverydayTopicListFailure)failureBlock;

/**获取分类子页面的subClass数据*/
- (void)getCategoryDetailSubClassDataWithDictionary:(NSDictionary *)parameterDic success:(GetCategorySubclassSuccess)successBlock failure:(GetCategorySubclassFailure)failureBlock;

/**通过分类获取列表数据*/
- (void)getListDataByCategoryWithDictionary:(NSDictionary *)parameterDic success:(GetListByCategorySuccess)successBlock failure:(GetListByCategoryFailure)failureBlock;

/**根据分类列表获取分类详情*/
- (void)getGoodsDetailDataWithDictionary:(NSDictionary *)parameterDic success:(GetListItemDetailDataSuccess)successBlock failure:(GetListItemDetailDataFailure)failureBlock;

/**获取种草小分队列表*/
- (void)getGrassListDataWithDictionary:(NSDictionary *)parameterDic success:(GetGrassListDataSuccess)successBlock failure:(GetGrassListDataFailure)failureBlock;

@end
