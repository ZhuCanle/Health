//
//  HeHttpRequest.h
//  Health
//
//  Created by 快摇002 on 2017/6/15.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeRequestEntity.h"
#import "HeChannelRequestData.h"
#import "HeChannelModel.h"
#import "HeAdListRequestData.h"
#import "HeAdModel.h"
#import "HeInfomationRequestData.h"
#import "HeInfomationModel.h"
#import "HeCategoryPostsData.h"
#import "HeSquarePostsData.h"
#import "HeSquareModel.h"
#import "HeSquareCommentModel.h"
#import "HeCategoryModel.h"
#import "HeInfoDetailData.h"
#import "HeInfomationDetaillModel.h"
#import "HeInfomationDetailCommentData.h"
#import "HeinfomationPriaseData.h"
#import "HeCollectionInfomationData.h"
#import "HePriaseData.h"

@interface HeHttpRequest : NSObject

/** 签名 */
@property (copy, nonatomic) NSString *sign;

@property (strong, nonatomic) HeRequestEntity *data;

@end
