//
//  UITableView+Regist.h
//  BanTang
//
//  Created by guanli on 16/3/22.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import <UIKit/UIKit.h>

//单元格的重用标示符与类名一致
@interface UITableView (Regist)

- (void)registNibCellWithClass:(Class)aClass;

- (void)registCellWithClass:(Class)aClass;

@end
