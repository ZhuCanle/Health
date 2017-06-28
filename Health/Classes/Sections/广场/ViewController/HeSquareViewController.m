//
//  HeSquareViewController.m
//  Health
//
//  Created by 快摇002 on 2017/6/13.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeSquareViewController.h"
#import "HeSquareAdListView.h"
#import "HeSquareCell.h"
#import "HeSquareCommentCell.h"
#import "HeSegmentControlView.h"
#import "HeSubCategoryView.h"

@interface HeSquareViewController ()<UITableViewDelegate,
                                    UITableViewDataSource,
                                    HeSegmentControlViewDelegate>
/** 广告轮播表头 */
@property (strong, nonatomic) HeSquareAdListView *tableViewHeaderView;
/** 频道选择Bar */
@property (strong, nonatomic) HeSegmentControlView *segmentControlBar;
/** 装频道选择Bar容器  */
@property (strong, nonatomic) UIView *sectiionContentView;
/** 主体TableView */
@property (strong, nonatomic) UITableView *tableView;

/** 广告数据数组 */
@property (strong, nonatomic) NSMutableArray<HeAdModel *> *adListCollection;
/** 频道数据数组 */
@property (strong, nonatomic) NSMutableArray<HeChannelModel *> *channelCollection;
/** 默认选择的热门广场频道id */
@property (strong, nonatomic) HeChannelModel  *defualChannel;
@property (strong, nonatomic) NSMutableArray <HeSquareModel *> *postsCollection;

@end

@implementation HeSquareViewController

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

    [self.view addSubview:self.tableView];

    self.tableView.tableHeaderView = self.tableViewHeaderView;

    //广告请求
    [self sendAdListReqeust];

    [self sendChannelListRequest];
}

#pragma mark - Private

//请求广告数据
- (void)sendAdListReqeust
{
    HeHttpRequest *request = [[HeHttpRequest alloc]init];
    request.sign = @"637586292ebf2c5fabab863734fc6a12";
    HeAdListRequestData *data = [[HeAdListRequestData alloc]init];
    data.showarea = 2;
    request.data = data;
    [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appshuffling/getshuffling?" successBlock:^(HeRespone *respone) {
        if (respone.state == 1)
        {
            self.adListCollection =  [HeAdModel mj_objectArrayWithKeyValuesArray:respone.data];
            [self.tableViewHeaderView setAdList:self.adListCollection clickCallBackBlock:^(NSInteger index) {
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
    data.channel_type = 2;
    request.data = data;
    @weakify(self);
    [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appchannel/list?" successBlock:^(HeRespone *respone) {
        @strongify(self);
        if (respone.state == 1)
        {
            self.channelCollection =  [HeChannelModel mj_objectArrayWithKeyValuesArray:respone.data];
            self.segmentControlBar.items = self.channelCollection;
            [self.tableView reloadData];

            //查找热门
            for (int i = 0; i < self.channelCollection.count; i++) {
                HeChannelModel *model = [self.channelCollection objectAtIndex:i];
                if ([model.channel_name isEqualToString:@"热门"]) {
                    self.defualChannel = model;
                    self.segmentControlBar.currentIndex = i;
                    break;
                }
            }
            //加载热门数据
            [self sendHostStatusListWithHotChannelId:self.defualChannel.channel_id];
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

//请求热门频道数据
- (void)sendHostStatusListWithHotChannelId:(NSInteger)identifier
{
    HeHttpRequest *request = [[HeHttpRequest alloc]init];
    request.sign = @"637586292ebf2c5fabab863734fc6a12";
    HeSquarePostsData *data = [[HeSquarePostsData alloc]init];
    data.channel_id = identifier;
    data.type = 1;
    request.data = data;
    @weakify(self);
    [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appposts/showposts?" successBlock:^(HeRespone *respone) {
        @strongify(self);
        if (respone.state == 1)
        {
            self.postsCollection = [HeSquareModel mj_objectArrayWithKeyValuesArray:respone.data];
            [self.tableView reloadData];
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

- (void)sendChannelSubCategoryWith:(NSInteger)channelId
{
    HeHttpRequest *request = [[HeHttpRequest alloc]init];
    request.sign = @"637586292ebf2c5fabab863734fc6a12";
    HeSquarePostsData *data = [[HeSquarePostsData alloc]init];
    data.channel_id = channelId;
    data.type = 2;
    request.data = data;
    @weakify(self);
    [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appposts/showposts?" successBlock:^(HeRespone *respone) {
        @strongify(self);
        if (respone.state == 1)
        {
            NSMutableArray *categoryCollection = [HeCategoryModel mj_objectArrayWithKeyValuesArray:respone.data];
            [self showSubCategory:categoryCollection];
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

- (void)showSubCategory:(NSMutableArray *)categoryCollection
{
    HeSubCategoryView *categoryView = [HeSubCategoryView getSubCategoryView];
    @weakify(self);
    [categoryView setSubCategoryViewTitle:self.defualChannel.channel_name items:categoryCollection callBackBlock:^(NSInteger index) {
        @strongify(self);
        HeCategoryModel *model = [categoryCollection objectAtIndex:index];

        //请求其他栏目下二级分类的帖子
        [self sendClassificationShowpostsWith:model];

    }];
    [categoryView show];
}

- (void)sendClassificationShowpostsWith:(HeCategoryModel *)subChannel
{
    HeHttpRequest *request = [[HeHttpRequest alloc]init];
    request.sign = @"637586292ebf2c5fabab863734fc6a12";
    HeCategoryPostsData *data = [[HeCategoryPostsData alloc]init];
    data.posts_classification_id = subChannel.posts_classification_id;
    data.page_count = @"";
    data.page_index = @"";

    request.data = data;
    @weakify(self);
    [HeHttpRequestManager sendAsynchronousRequest:request KeyPath:@"healthssm/appposts/classificationshowposts?" successBlock:^(HeRespone *respone) {
        @strongify(self);
        if (respone.state == 1)
        {
            self.postsCollection = [HeSquareModel mj_objectArrayWithKeyValuesArray:respone.data];
            [self.tableView  setContentOffset:CGPointMake(0,0) animated:NO];
            [self.tableView reloadData];
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

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.postsCollection.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HeSquareModel *model = [self.postsCollection objectAtIndex:section];
    return model.commentInfor.count+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 && self.channelCollection.count > 0) {
        return 75;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 && self.channelCollection.count > 0) {
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterView"];
        if (!headerView) {
            headerView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"UITableViewHeaderFooterView"];
        }
        [headerView.contentView addSubview:self.sectiionContentView];
        return headerView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        HeSquareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeSquareCell"];
        HeSquareModel *model = [self.postsCollection objectAtIndex:indexPath.section];
        cell.model = model;
        return cell;
    }else
    {
        HeSquareCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeSquareCommentCell"];
        HeSquareModel *model = [self.postsCollection objectAtIndex:indexPath.section];
        HeSquareCommentModel *comment = [model.commentInfor objectAtIndex:indexPath.row
        - 1];
        cell.model = comment;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        HeSquareModel *model = [self.postsCollection objectAtIndex:indexPath.section];
        return [tableView fd_heightForCellWithIdentifier:@"HeSquareCell" cacheByIndexPath:indexPath configuration:^(HeSquareCell *cell) {
            cell.model = model;
        }];
    }else
    {
        HeSquareModel *model = [self.postsCollection objectAtIndex:indexPath.section];
        HeSquareCommentModel *comment = [model.commentInfor objectAtIndex:indexPath.row
                                         - 1];
        return [tableView fd_heightForCellWithIdentifier:@"HeSquareCommentCell" cacheByIndexPath:indexPath configuration:^(HeSquareCommentCell *cell) {
            cell.model = comment;
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= self.tableViewHeaderView.height) {
        [self.view insertSubview:self.segmentControlBar aboveSubview:self.tableView];
    }else{

        [self.sectiionContentView addSubview:self.segmentControlBar];
    }
}

#pragma mark - HeSegmentControlViewDelegate

- (void)segmentControlViewDidSelectedAtIndex:(NSInteger)index
{
    HeChannelModel *model = [self.channelCollection objectAtIndex:index];
    if ([model.channel_name isEqualToString:@"热门"])
    {

    }else
    {
        [self sendChannelSubCategoryWith:model.channel_id];
        self.defualChannel = model;
    }

}

#pragma mark - Lazyload

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [_tableView registerNib:[HeSquareCell loadNib] forCellReuseIdentifier:@"HeSquareCell"];
        [_tableView registerNib:[HeSquareCommentCell loadNib] forCellReuseIdentifier:@"HeSquareCommentCell"];

        @weakify(self)
        _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView.mj_header endRefreshing];
            });

        }];
    }
    return _tableView;
}

- (HeSquareAdListView *)tableViewHeaderView
{
    if (_tableViewHeaderView == nil) {
        _tableViewHeaderView = [[HeSquareAdListView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, WIDTH *9/16)];
        _tableViewHeaderView.layer.masksToBounds = YES;
    }
    return _tableViewHeaderView;
}

- (HeSegmentControlView *)segmentControlBar
{
    if (_segmentControlBar == nil) {
        _segmentControlBar = [[HeSegmentControlView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 75)];
        _segmentControlBar.delegate = self;
    }
    return _segmentControlBar;
}

- (UIView *)sectiionContentView
{
    if (_sectiionContentView == nil) {
        _sectiionContentView= [[UIView alloc]initWithFrame:self.segmentControlBar.bounds];
        [_sectiionContentView addSubview:self.segmentControlBar];
    }
    return _sectiionContentView;
}

- (NSMutableArray *)postsCollection
{
    if (_postsCollection == nil) {
        _postsCollection = [[NSMutableArray alloc]init];
    }
    return _postsCollection;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
