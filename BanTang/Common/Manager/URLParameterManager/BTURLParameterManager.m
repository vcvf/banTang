//
//  BTURLParameterManager.m
//  BanTang
//
//  Created by guanli on 16/4/21.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BTURLParameterManager.h"

@implementation BTURLParameterManager

+ (id)sharedInstance {
        NSMutableDictionary *parameterDic = [[NSMutableDictionary alloc]init];;
        [parameterDic setObject:@"com.jzyd.BanTang" forKey:@"app_id"];
        [parameterDic setObject:@"5.7" forKey:@"app_versions"];
        [parameterDic setObject:@"appStore" forKey:@"channel_name"];
        [parameterDic setObject:@"bt_app_ios" forKey:@"client_id"];
        [parameterDic setObject:@"9c1e6634ce1c5098e056628cd66a17a5" forKey:@"client_secret"];
        [parameterDic setObject:@"9.3.1" forKey:@"os_version"];
        [parameterDic setObject:@"1242" forKey:@"screensize"];
        [parameterDic setObject:@"iPhone8%2C2" forKey:@"track_device_info"];
        [parameterDic setObject:@"2EEE94FE-4CD8-48C8-9AD2-893D36546E64" forKey:@"track_deviceid"];
        [parameterDic setObject:@"12" forKey:@"v"];
    return parameterDic;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
