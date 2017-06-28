//
//  HeSubCategoryView.h
//  Health
//
//  Created by 快摇002 on 2017/6/17.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeCategoryModel.h"

typedef void(^subCategoryViewDidSelected)(NSInteger);

@interface HeSubCategoryView : UIView

+ (instancetype)getSubCategoryView;

- (void)show;

- (void)dismiss;

- (void)setSubCategoryViewTitle:(NSString *)title items:(NSMutableArray *)items callBackBlock:(subCategoryViewDidSelected)block;

@end
