//
//  HeCommentInfomationData.h
//  Health
//
//  Created by 快摇002 on 2017/6/19.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeRequestEntity.h"

@interface HeCommentInfomationData : HeRequestEntity

@property (assign, nonatomic) NSInteger information_id;//资讯新闻ID
@property (assign, nonatomic) NSInteger comment_typ;//评论所在的区域（1、资讯 2、广场）
@property (copy, nonatomic) NSString *critics_user_id;//评论人ID
@property (copy, nonatomic) NSString *by_critics_user_id;//评论接收人ID（可以为空）
@property (copy, nonatomic) NSString *comment_content;//评论内容
@property (copy, nonatomic) NSString *comment_img;//MultipartFile类型文件

@end
