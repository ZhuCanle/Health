//
//  HeInformationViewController.m
//  Health
//
//  Created by 快摇002 on 2017/6/13.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeInformationViewController.h"
#import "HeAdListHeaderView.h"
#import "HeCustomTableView.h"
#import "HeSegmentControlView.h"
#import "LevUtility.h"
#import "SwipeTableView.h"
#import "STRefresh.h"
#import <objc/message.h>
#import "HeInfomationEntity.h"
#import "HeSharePopView.h"
#import "HeInfomationDetailsViewController.h"

@interface HeInformationViewController ()<SwipeTableViewDelegate,
                                          SwipeTableViewDataSource,
                                          UIGestureRecognizerDelegate,
                                          UIViewControllerTransitioningDelegate,
                                          HeSegmentControlViewDelegate,
                                          UIScrollViewDelegate,
                                            CustomTableViewDidSelectdDelegate>

/** 主体TableView */
@property (nonatomic, strong) SwipeTableView * swipeTableView;
/** 主体TableView的表头 */
@property (nonatomic, strong) HeAdListHeaderView * tableViewHeader;
/** 频道选择Bar */
@property (strong, nonatomic) HeSegmentControlView *segmentControlBar;
/** 资讯数据数组 */
@property (strong, nonatomic) NSMutableArray<HeInfomationEntity *> *infomationCollection;
/** 广告数据数组 */
@property (strong, nonatomic) NSMutableArray<HeAdModel *> *adListCollection;
/** 频道数据数组 */
@property (strong, nonatomic) NSMutableArray<HeChannelModel *> *channelCollection;
/** 当前频道 */
@property (strong, nonatomic) HeChannelModel *currentChannel;
/** 搜索按钮 */
@property (strong, nonatomic) UIButton *searchButon;

@end

@implementation HeInformationViewController

#pragma mark - Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.swipeTableView];
    [self.tableViewHeader addSubview:self.searchButon];

    //广告请求
    [self sendAdListReqeust];

    //频道请求
    [self sendChannelListRequest];
}

#pragma mark - Private

//请求广告数据
- (void)sendAdListReqeust
{
    HeHttpRequest *request = [[HeHttpRequest alloc]init];
    request.sign = @"637586292ebf2c5fabab863734fc6a12";
    HeAdListRequestData *data = [[HeAdListRequestData alloc]init];
    data.showarea = 1;
    request.data = data;
    [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appshuffling/getshuffling?" successBlock:^(HeRespone *respone) {
        if (respone.state == 1)
        {
            self.adListCollection =  [HeAdModel mj_objectArrayWithKeyValuesArray:respone.data];
            [self.tableViewHeader setAdList:self.adListCollection clickCallBackBlock:^(NSInteger index) {
            }];
        }else
        {
            [MBProgressHUD showText:@"数据请求失败" withTime:1.5];
        }
    } failureBlock:^(NSError *error) {

    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {

    }];
}

//请求频道数据
- (void)sendChannelListRequest
{
    HeHttpRequest *request = [[HeHttpRequest alloc]init];
    request.sign = @"637586292ebf2c5fabab863734fc6a12";
    HeChannelRequestData *data = [[HeChannelRequestData alloc]init];
    data.channel_type = 1;
    request.data = data;
    @weakify(self);
    [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appchannel/list?" successBlock:^(HeRespone *respone) {
        @strongify(self);
        if (respone.state == 1)
        {
            self.channelCollection =  [HeChannelModel mj_objectArrayWithKeyValuesArray:respone.data];
            self.segmentControlBar.items = self.channelCollection;

            [self.swipeTableView reloadData];

            //默认选择第一个频道
            self.currentChannel = [self.channelCollection objectAtIndex:0];
            self.segmentControlBar.currentIndex = 0;

            //根据请求到的频道对应创建infomationCollection中的infomationEntity对象
            for (NSInteger i = 0; i < self.channelCollection.count; i++) {
                HeInfomationEntity *entity = [[HeInfomationEntity alloc]init];
                [self.infomationCollection addObject:entity];
            }
            //请求第一个频道的数据
            [self sendInfomationRequestWithChannelIndex:0];
        }
        else
        {
            [MBProgressHUD showText:@"数据请求失败" withTime:1.5];
            [MBProgressHUD hideLoadingToView:self.view];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingToView:self.view];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    }];
}

/**
 根据当前index请求对应的数据

 @param index swipeView.currentItemIndex
 */
- (void)sendInfomationRequestWithChannelIndex:(NSInteger)index
{
    HeHttpRequest *request = [[HeHttpRequest alloc]init];

    request.sign = @"637586292ebf2c5fabab863734fc6a12";
    HeInfomationRequestData *data = [[HeInfomationRequestData alloc]init];
    data.channel_id = [NSString stringWithFormat:@"%ld",self.currentChannel.channel_id];
    data.page_index = @"";
    data.page_count = @"";
    request.data = data;

    @weakify(self);
    [MBProgressHUD showLoadingToView:self.view];
    [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appinformationmanager/listinfor?" successBlock:^(HeRespone *respone) {
        [MBProgressHUD hideLoadingToView:self.view];
        @strongify(self);
        if (respone.state == 1)
        {
            HeInfomationEntity *entity = [self.infomationCollection objectAtIndex:index];
            entity.infomations = [HeInfomationModel mj_objectArrayWithKeyValuesArray:respone.data];
            // 请求数据后刷新相应的item
//            HeCustomTableView * tableView = (HeCustomTableView *)self.swipeTableView.currentItemView;
//            [tableView refreshWithData:entity.infomations atIndex:index];

            [_swipeTableView scrollToItemAtIndex:index animated:YES];

            ((void (*)(void *, SEL, NSNumber *, NSInteger))objc_msgSend)((__bridge void *)(self.swipeTableView.currentItemView),@selector(refreshWithData:atIndex:), entity.infomations,index);

        }
        else
        {
            [MBProgressHUD showText:@"数据请求失败" withTime:1.5];
            [MBProgressHUD hideLoadingToView:self.view];

            [_swipeTableView scrollToItemAtIndex:index animated:YES];

        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingToView:self.view];

        [_swipeTableView scrollToItemAtIndex:index animated:YES];

    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    }];
}

#pragma mark - HeSegmentControlViewDelegate

- (void)segmentControlViewDidSelectedAtIndex:(NSInteger)index
{
    self.currentChannel = [self.channelCollection objectAtIndex:index];

    HeInfomationEntity *entity = [self.infomationCollection objectAtIndex:index];
    if (entity.infomations.count == 0) {
        [self sendInfomationRequestWithChannelIndex:index];
    }else
    {
        [_swipeTableView scrollToItemAtIndex:index animated:YES];
           ((void (*)(void *, SEL, NSNumber *, NSInteger))objc_msgSend)((__bridge void *)(self.swipeTableView.currentItemView),@selector(refreshWithData:atIndex:), entity.infomations,index);

    }
}

#pragma mark - SwipeTableView Delegate

- (NSInteger)numberOfItemsInSwipeTableView:(SwipeTableView *)swipeView
{
    return self.channelCollection.count;
}

- (UIScrollView *)swipeTableView:(SwipeTableView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIScrollView *)view
{
    HeCustomTableView * tableView = (HeCustomTableView *)view;
    // 重用
    if (nil == tableView) {
        tableView = [[HeCustomTableView alloc]initWithFrame:swipeView.bounds style:UITableViewStylePlain];
    }

    tableView.outsideDelegate = self;

    HeInfomationEntity *entity = [self.infomationCollection objectAtIndex:index];
    [tableView refreshWithData:entity.infomations atIndex:index];
    view = tableView;

    @weakify(self);
    tableView.header = [STRefreshHeader headerWithRefreshingBlock:^(STRefreshHeader *header) {
        @strongify(self);
        entity.page = 0;
        //下拉刷新当前频道
        HeHttpRequest *request = [[HeHttpRequest alloc]init];
        request.sign = @"637586292ebf2c5fabab863734fc6a12";
        HeInfomationRequestData *data = [[HeInfomationRequestData alloc]init];
        data.channel_id = [NSString stringWithFormat:@"%ld",self.currentChannel.channel_id];
        data.page_index = [NSString stringWithFormat:@"%ld",entity.page];
        data.page_count = @"";
        request.data = data;
        @weakify(self);
        [MBProgressHUD showLoadingToView:self.view];
        [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appinformationmanager/listinfor?" successBlock:^(HeRespone *respone) {
            [MBProgressHUD hideLoadingToView:self.view];
            @strongify(self);
            if (respone.state == 1)
            {
                entity.infomations = [HeInfomationModel mj_objectArrayWithKeyValuesArray:respone.data];
                [_swipeTableView scrollToItemAtIndex:index animated:YES];
                ((void (*)(void *, SEL, NSNumber *, NSInteger))objc_msgSend)((__bridge void *)(self.swipeTableView.currentItemView),@selector(refreshWithData:atIndex:), entity.infomations,index);
            }
            else
            {
                [MBProgressHUD showText:@"数据请求失败" withTime:1.5];
                [MBProgressHUD hideLoadingToView:self.view];
                [_swipeTableView scrollToItemAtIndex:index animated:YES];
            }
            [header endRefreshing];
        } failureBlock:^(NSError *error) {
            [header endRefreshing];
            [MBProgressHUD hideLoadingToView:self.view];
            
            [_swipeTableView scrollToItemAtIndex:index animated:YES];
            
        } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        }];
    }];

    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        entity.page +=1;
        //下拉刷新当前频道
        HeHttpRequest *request = [[HeHttpRequest alloc]init];
        request.sign = @"637586292ebf2c5fabab863734fc6a12";
        HeInfomationRequestData *data = [[HeInfomationRequestData alloc]init];
        data.channel_id = [NSString stringWithFormat:@"%ld",self.currentChannel.channel_id];
        data.page_index = [NSString stringWithFormat:@"%ld",entity.page];
        data.page_count = @"";
        request.data = data;
        @weakify(self);
        [MBProgressHUD showLoadingToView:self.view];
        [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appinformationmanager/listinfor?" successBlock:^(HeRespone *respone) {
            [MBProgressHUD hideLoadingToView:self.view];
            @strongify(self);
            if (respone.state == 1)
            {
                [entity.infomations addObjectsFromArray:[HeInfomationModel mj_objectArrayWithKeyValuesArray:respone.data]];
                [_swipeTableView scrollToItemAtIndex:index animated:YES];
                ((void (*)(void *, SEL, NSNumber *, NSInteger))objc_msgSend)((__bridge void *)(self.swipeTableView.currentItemView),@selector(refreshWithData:atIndex:), entity.infomations,index);

                if ( [HeInfomationModel mj_objectArrayWithKeyValuesArray:respone.data].count == 0)
                {
                    [MBProgressHUD showText:@"没有更多的数据" withTime:1.5];
                }
            }
            else
            {
//                [MBProgressHUD showText:@"数据请求失败" withTime:1.5];
                [MBProgressHUD hideLoadingToView:self.view];
                [_swipeTableView scrollToItemAtIndex:index animated:YES];
            }

            [tableView.mj_footer endRefreshing];
        } failureBlock:^(NSError *error) {
            [MBProgressHUD hideLoadingToView:self.view];
            [tableView.mj_footer endRefreshing];

            [_swipeTableView scrollToItemAtIndex:index animated:YES];

        } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        }];

    }];

    // 在没有设定下拉刷新宏的条件下，自定义的下拉刷新需要做 refreshheader 的 frame 处理
    [self configRefreshHeaderForItem:view];

    return view;
}

// swipetableView index变化，改变seg的index
- (void)swipeTableViewCurrentItemIndexDidChange:(SwipeTableView *)swipeView
{
    self.segmentControlBar.currentIndex = swipeView.currentItemIndex;
}

// 滚动结束请求数据
- (void)swipeTableViewDidEndDecelerating:(SwipeTableView *)swipeView
{
    self.currentChannel = [self.channelCollection objectAtIndex:swipeView.currentItemIndex];

     HeInfomationEntity *entity = [self.infomationCollection objectAtIndex:swipeView.currentItemIndex];
    if (entity.infomations.count == 0) {
        [self sendInfomationRequestWithChannelIndex:swipeView.currentItemIndex];
    }else
    {
        // 请求数据后刷新相应的item
        HeCustomTableView * tableView = (HeCustomTableView *)self.swipeTableView.currentItemView;
        [tableView refreshWithData:entity.infomations atIndex:swipeView.currentItemIndex];
    }
}

/**
 *  以下两个代理，在未定义宏 #define ST_PULLTOREFRESH_HEADER_HEIGHT，并自定义下拉刷新的时候，必须实现
 *  如果设置了下拉刷新的宏，以下代理可根据需要实现即可
 */
- (BOOL)swipeTableView:(SwipeTableView *)swipeTableView shouldPullToRefreshAtIndex:(NSInteger)index {
    return YES;
}

- (CGFloat)swipeTableView:(SwipeTableView *)swipeTableView heightForRefreshHeaderAtIndex:(NSInteger)index {
    return kSTRefreshHeaderHeight;
}

/**
 *  采用自定义修改下拉刷新，此时不会定义宏 #define ST_PULLTOREFRESH_HEADER_HEIGHT
 *  对于一些下拉刷新控件，可能会在`layouSubViews`中设置RefreshHeader的frame。所以，需要在itemView有效的方法中改变RefreshHeader的frame，如 `scrollViewDidScroll:`
 */
- (void)configRefreshHeaderForItem:(UIScrollView *)itemView {

#if !defined(ST_PULLTOREFRESH_HEADER_HEIGHT)
    STRefreshHeader * header = itemView.header;
    header.st_y = - (self.tableViewHeader.st_height + (self.segmentControlBar.height + self.tableViewHeader.height));
#endif
}

#pragma mark - CustomTableViewDidSelectdDelegate

- (void)tableViewDidSelectAtIndePath:(NSIndexPath *)indexPath with:(NSMutableArray *)infomations
{
    HeInfomationModel *model = infomations[indexPath.row];
    HeInfomationDetailsViewController *details = [[HeInfomationDetailsViewController alloc]init];
    details.hidesBottomBarWhenPushed = YES;
    details.information_id = model.information_id;
    [self.navigationController pushViewController:details animated:YES];
}

- (void)scrollViewDidScroll:(UITableView *)tableView
{
//    NSLog(@"%.f",tableView.contentOffset.y);
//    if (tableView.contentOffset.y <= -self.segmentControlBar.height)
//    {
//        self.swipeTableView.swipeHeaderTopInset = 20;
//    }else
//    {
//        self.swipeTableView.swipeHeaderTopInset = 0;
//    }
}

#pragma mark - Lazyload

- (SwipeTableView *)swipeTableView
{
    if (_swipeTableView == nil)
    {
        _swipeTableView = [[SwipeTableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 49)];
        _swipeTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _swipeTableView.delegate = self;
        _swipeTableView.dataSource = self;
        _swipeTableView.shouldAdjustContentSize = YES;
        _swipeTableView.swipeHeaderView = self.tableViewHeader;
        _swipeTableView.swipeHeaderBar = self.segmentControlBar;
        _swipeTableView.swipeHeaderBarScrollDisabled = YES;
        _swipeTableView.swipeHeaderTopInset = 0;
    }
    return _swipeTableView;
}

- (HeAdListHeaderView *)tableViewHeader
{
    if (_tableViewHeader == nil) {
        _tableViewHeader = [[HeAdListHeaderView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH *9/16)];
        _tableViewHeader.layer.masksToBounds = YES;
    }
    return _tableViewHeader;
}

- (NSMutableArray *)adListCollection
{
    if (_adListCollection == nil) {
        _adListCollection = [[NSMutableArray alloc]init];
    }
    return _adListCollection;
}

- (NSMutableArray *)channelCollection
{
    if (_channelCollection == nil) {
        _channelCollection = [[NSMutableArray alloc]init];
    }
    return _channelCollection;
}

- (HeSegmentControlView *)segmentControlBar
{
    if (_segmentControlBar == nil) {
        _segmentControlBar = [[HeSegmentControlView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 85)];
        _segmentControlBar.delegate = self;
    }
    return _segmentControlBar;
}

- (NSMutableArray *)infomationCollection
{
    if (_infomationCollection == nil) {
        _infomationCollection = [[NSMutableArray alloc]init];
    }
    return _infomationCollection;
}

- (UIButton *)searchButon
{
    if (_searchButon == nil) {
        _searchButon = [[UIButton alloc]init];
        _searchButon.frame = CGRectMake(WIDTH - 38, 27, 27, 27);

        [_searchButon setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [[_searchButon rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            NSLog(@"搜索");

            [MBProgressHUD showText:@"搜索" withTime:1];

        }];
    }
    return _searchButon;
}

@end
