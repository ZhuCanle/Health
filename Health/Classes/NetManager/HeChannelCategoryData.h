//
//  HeChannelCategoryData.h
//  Health
//
//  Created by 快摇002 on 2017/6/17.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeChannelCategoryData : NSObject

@property (copy, nonatomic) NSString * channel_id;

@property (copy, nonatomic) NSString * page_index;

@property (copy, nonatomic) NSString * page_count;
/** 类型（1、获取热门下帖子列表 2、获取频道下二级分类）*/
@property (assign, nonatomic) NSInteger type;

@end
