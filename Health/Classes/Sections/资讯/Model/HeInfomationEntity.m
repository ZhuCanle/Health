//
//  HeInfomationEntity.m
//  Health
//
//  Created by 快摇002 on 2017/6/16.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeInfomationEntity.h"

@implementation HeInfomationEntity

- (instancetype)init
{
    self = [super init];
    if (self) {

        //默认第一页
        _page = 1;

        _infomations = [NSMutableArray array];
    }
    return self;
}

@end
