//
//  HeCustomTableView.h
//  Health
//
//  Created by 快摇002 on 2017/6/14.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTableViewDidSelectdDelegate <NSObject>

- (void)tableViewDidSelectAtIndePath:(NSIndexPath *)indexPath with:(NSMutableArray *)infomations;

- (void)scrollViewDidScroll:(UITableView *)tableView;

@end

@interface HeCustomTableView : UITableView

/**
 设置刷新对应位置的表格
 @param infomations 数据
 @param index 表格所在的位置
 */

- (void)refreshWithData:(NSMutableArray <HeInfomationModel *>*)infomations atIndex:(NSInteger)index;

@property (weak, nonatomic) id<CustomTableViewDidSelectdDelegate> outsideDelegate;

@end
