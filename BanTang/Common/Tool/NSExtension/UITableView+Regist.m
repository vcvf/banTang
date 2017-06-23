//
//  UITableView+Regist.m
//  BanTang
//
//  Created by guanli on 16/3/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "UITableView+Regist.h"

@implementation UITableView (Regist)

- (void)registNibCellWithClass:(Class)aClass {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(aClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(aClass)];
}

- (void)registCellWithClass:(Class)aClass {
    [self registerClass:aClass forCellReuseIdentifier:NSStringFromClass(aClass)];
}

@end
