//
//  HeInfomationDetailCommentData.h
//  Health
//
//  Created by 快摇002 on 2017/6/19.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeRequestEntity.h"

@interface HeInfomationDetailCommentData : HeRequestEntity

@property (assign, nonatomic) NSInteger comment_article_id;

@property (copy, nonatomic) NSString *page_index;
@property (copy, nonatomic) NSString *page_count;

@property (assign, nonatomic) NSInteger comment_type;


@end
