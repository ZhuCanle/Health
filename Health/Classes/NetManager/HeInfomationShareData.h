//
//  HeInfomationShareData.h
//  Health
//
//  Created by 快摇002 on 2017/6/19.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeRequestEntity.h"

@interface HeInfomationShareData : HeRequestEntity

@property (copy, nonatomic) NSString *user_id;//分享用户ID
@property (assign, nonatomic) NSInteger *information_id;//资讯新闻ID


@end