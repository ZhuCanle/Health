//
//  HeCategoryPostsData.h
//  Health
//
//  Created by 快摇002 on 2017/6/17.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeCategoryPostsData : HeRequestEntity
/** 帖子二级分类ID*/
@property (assign, nonatomic) NSInteger posts_classification_id;
/** 分页索引*/
@property (copy, nonatomic) NSString *page_index;
/** 分页索引*/
@property (copy, nonatomic) NSString *page_count;


@end
