//
//  HeAdModel.h
//  Health
//
//  Created by 快摇002 on 2017/6/15.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeAdModel : NSObject
/**
 轮播图地址
 */
@property (copy, nonatomic) NSString *shuffling_img_address;

/**
 轮播图跳转地址
 */
@property (copy, nonatomic) NSString *shuffling_jump_address;

@end
