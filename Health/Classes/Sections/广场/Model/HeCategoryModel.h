//
//  HeCategoryModel.h
//  Health
//
//  Created by 快摇002 on 2017/6/17.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeCategoryModel : NSObject
/** 帖子二级分类的名称*/
@property (copy, nonatomic) NSString *posts_classification_name;
/** 帖子二级分类的ID*/
@property (assign, nonatomic) NSInteger posts_classification_id;

@end
