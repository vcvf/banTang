//
//  BtHomeCollectionViewCell.m
//  BanTang
//
//  Created by guanli on 16/5/23.
//  Copyright © 2016年 CaoFei. All rights reserved.
//

#import "BtHomeCollectionViewCell.h"
#import "BTHomeTopicTableViewCell.h"

@interface BtHomeCollectionViewCell () <UITableViewDataSource>

@end

@implementation BtHomeCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _tableV = [[UITableView alloc] init];
        _tableV.backgroundColor = [UIColor whiteColor];
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableV registCellWithClass:[BTHomeTopicTableViewCell class]];
        
        _tableV.dataSource = self;
        [self addSubview:_tableV];
        [_tableV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BTHomeTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BTHomeTopicTableViewCell class]) forIndexPath:indexPath];
    [cell setCellInfoWithModal:[self.topicArray validObjectForIndex:indexPath.row]];
    return cell;
}



@end
