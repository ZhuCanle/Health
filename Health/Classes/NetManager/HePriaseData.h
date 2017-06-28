//
//  HePriaseData.h
//  Health
//
//  Created by 快摇002 on 2017/6/19.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeRequestEntity.h"

@interface HePriaseData : HeRequestEntity

@property (assign, nonatomic) NSInteger comment_id;//评论ID
@property (assign, nonatomic) NSInteger comment_article_id;//评论文章ID
@property (assign, nonatomic) NSInteger comment_thump_up_number;//点赞数

@end
