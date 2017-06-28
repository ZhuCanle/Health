//
//  HeAdListHeaderView.h
//  Health
//
//  Created by 快摇002 on 2017/6/14.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <SwipeTableView/SwipeTableView.h>

typedef void(^headerViewDidClickBlock)(NSInteger);

@interface HeAdListHeaderView : STHeaderView

/**
 设置表头广告内容和回调

 @param adLists 广告数组
 @param block   点击广告回调广告index
 */
- (void)setAdList:(NSMutableArray *)adLists clickCallBackBlock:(headerViewDidClickBlock)block;

@end
