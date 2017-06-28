//
//  HeAdListHeaderView.m
//  Health
//
//  Created by 快摇002 on 2017/6/14.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeAdListHeaderView.h"
#import <SDCycleScrollView.h>
#import "HeAdModel.h"

@interface HeAdListHeaderView ()<SDCycleScrollViewDelegate>

@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;
@property (copy, nonatomic) headerViewDidClickBlock block;

@end

@implementation HeAdListHeaderView


#pragma mark - Lazyload

- (SDCycleScrollView *)cycleScrollView
{
    if (_cycleScrollView == nil) {
        _cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH  , WIDTH *9/16)];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.delegate = self;
        _cycleScrollView.pageControlDotSize = CGSizeMake(6, 6);
        _cycleScrollView.currentPageDotColor = THEME_GREEN;
        _cycleScrollView.pageDotColor = [UIColor colorWithHexString:@"#cccccc"];
    }
    return _cycleScrollView;
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.cycleScrollView];
    }
    return self;
}

/**
 设置表头广告内容和回调

 @param adLists 广告数组
 @param block   点击广告回调广告index
 */
- (void)setAdList:(NSMutableArray *)adLists clickCallBackBlock:(headerViewDidClickBlock)block
{
    NSMutableArray *images = [NSMutableArray array];
    for (NSInteger i = 0; i < adLists.count; i ++) {
        HeAdModel *model = [adLists objectAtIndex:i];
        [images addObject:model.shuffling_img_address];
    }
    [self.cycleScrollView setImageURLStringsGroup:images];
    _block = block;
}

#pragma mark -SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    !self.block ? : self.block(index);
}


@end
