//
//  HeAdListRequestData.h
//  Health
//
//  Created by 快摇002 on 2017/6/15.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeRequestEntity.h"

@interface HeAdListRequestData : HeRequestEntity
/**
 广告列表请求参数,轮播图展示区域(1、资讯 )
 */
@property (assign, nonatomic) NSInteger showarea;

@end
