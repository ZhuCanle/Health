//
//  HeSquareCommentModel.h
//  Health
//
//  Created by 快摇002 on 2017/6/17.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeImageModel.h"

@interface HeSquareCommentModel : NSObject


@property (assign, nonatomic) NSInteger comment_id;

/** 评论人昵称 */
@property (copy, nonatomic) NSString *critics_user_nickname;
/** 评论人头像 */
@property (copy, nonatomic) NSString *critics_user_head_img;
/** 评论人ID */
@property (copy, nonatomic) NSString *critics_user_id;

/** 评论接收人昵称 */
@property (copy, nonatomic) NSString *by_critics_user_nickname;
/** 评论接收人头像 */
@property (copy, nonatomic) NSString *by_critics_user_head_img;
/** 评论接收人id */
@property (copy, nonatomic) NSString *by_critics_user_id;
/** 评论内容 */
@property (copy, nonatomic) NSString *comment_content;
/** 评论图片 */
@property (copy, nonatomic) NSString *comment_img;

@property (assign, nonatomic) float comment_img_width;

@property (assign, nonatomic) float comment_img_height;

@property (assign, nonatomic) NSInteger comment_thump_up_number;
/** 评论是否置顶 */
@property (assign, nonatomic) NSInteger comment_top_state;
/** 评论发布时间 */
@property (copy, nonatomic) NSString *comment_create_time;


/** 资讯模块评论图片 */
@property (strong, nonatomic) HeImageModel *comment_app_img;

@property (copy, nonatomic) NSString *quote_comment_img;
@property (copy, nonatomic) NSString *quote_comment_content;

@property (assign, nonatomic) NSInteger isPrase;


@end
