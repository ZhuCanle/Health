//
//  HeSquarePostsData.h
//  Health
//
//  Created by 快摇002 on 2017/6/17.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeRequestEntity.h"

@interface HeSquarePostsData : HeRequestEntity

/** 广场下的频道ID*/
@property (assign, nonatomic) NSInteger channel_id;
/** 分页索引*/
@property (copy, nonatomic) NSString *page_index;
/** 分页索引*/
@property (copy, nonatomic) NSString *page_count;
/**（1、获取热门下帖子列表 2、获取频道下二级分类）*/
@property (assign, nonatomic) NSInteger type;

@end
