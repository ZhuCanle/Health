//
//  HeCustomTableView.m
//  Health
//
//  Created by 快摇002 on 2017/6/14.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeCustomTableView.h"
#import "HeInfomationCell.h"
#import "STRefresh.h"
#import "HeInfomationModel.h"
#import "HeReverseInfomationCell.h"

@interface HeCustomTableView ()<UITableViewDataSource,
                                UITableViewDelegate>
//所在的位置
@property (nonatomic, assign) NSInteger itemIndex;

@property (strong, nonatomic) NSMutableArray *infomations;

@end

@implementation HeCustomTableView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [UIView new];
        self.itemIndex = -1;
        
        [self registerNib:[HeInfomationCell loadNib] forCellReuseIdentifier:@"HeInfomationCell"];
        [self registerNib:[HeReverseInfomationCell loadNib] forCellReuseIdentifier:@"HeReverseInfomationCell"];

    }
    return self;
}

#pragma mark - Public

- (void)refreshWithData:(NSMutableArray <HeInfomationModel *>*)infomations atIndex:(NSInteger)index;
{
    _infomations = infomations;
    _itemIndex = index;
    [self reloadData];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infomations.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeInfomationModel *infomation = [self.infomations objectAtIndex:indexPath.row];
    NSLog(@"*****%@",infomation.label_name);
    if (infomation.information_img_show_location == 1) {
        HeReverseInfomationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeReverseInfomationCell"];
        cell.infomation = infomation;
        return cell;
    }else
    {
        HeInfomationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeInfomationCell"];
        cell.infomation = infomation;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.outsideDelegate) {
        [self.outsideDelegate tableViewDidSelectAtIndePath:indexPath with:self.infomations];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (self.outsideDelegate) {
        [self.outsideDelegate scrollViewDidScroll:self];
    }

#if !defined(ST_PULLTOREFRESH_HEADER_HEIGHT)
    STRefreshHeader * header = self.header;
    CGFloat orginY = - (header.st_height + self.swipeTableView.swipeHeaderView.st_height + self.swipeTableView.swipeHeaderBar.st_height);
    if (header.st_y != orginY) {
        header.st_y = orginY;
    }
#endif
}

@end
