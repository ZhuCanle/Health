//
//  HeSegmentControlView.m
//  Health
//
//  Created by 快摇002 on 2017/6/15.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeSegmentControlView.h"
#import "JXButton.h"

#define ITEM_WIDTH 60
#define ITEM_HEIGHT 50
#define BUTTON_INTERVAL 8

@interface HeSegmentControlView ()

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) NSMutableArray *itemsArray;

@property (strong, nonatomic) SegmentItemView *selectedItem;

@property (assign, nonatomic) CGFloat leftMargin;
@property (assign, nonatomic) CGFloat rightMargin;

@property (strong, nonatomic) UIView *lineView;

@end

@implementation HeSegmentControlView

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (NSMutableArray *)itemsArray
{
    if (_itemsArray == nil) {
        _itemsArray = [[NSMutableArray alloc]init];
    }
    return _itemsArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        self.backgroundColor = [UIColor whiteColor];

        _lineView = [[UIView alloc]initWithFrame:CGRectMake(-ITEM_WIDTH, frame.size.height - 1, 50, 1)];
        _lineView.backgroundColor = THEME_GREEN;
        [self.scrollView addSubview:_lineView];
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    _items = items;

    _leftMargin = 0;
    _rightMargin = 0;
    if (items.count < 4) {
        _leftMargin = 30;
        _rightMargin = 30;
    }

    while (items.count > self.itemsArray.count) {
        SegmentItemView *button = [SegmentItemView viewWithXib];
        [self.itemsArray addObject:button];
    }

    for (NSInteger i = 0; i < self.itemsArray.count; i ++ )
    {
         SegmentItemView *button = [self.itemsArray objectAtIndex:i];
        if (i < _items.count) {
            button.hidden = NO;
            HeChannelModel *model = [self.items objectAtIndex:i];
            [button.itemImageView setImageWithURL:[NSURL URLWithString:model.channel_img] placeholder:[UIImage imageNamed:@"loading"]];
            button.titleLabel.text = model.channel_name;
//            [button.itemImageView setImageWithURL:[NSURL URLWithString:model.channel_img] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"loading"]];
//            [button setTitle:model.channel_name forState:UIControlStateNormal];
//            [button setTitleColor:THEME_GREEN forState:UIControlStateSelected];
//            [button setTitleColor:UIColorFromRGB(0x444444) forState:UIControlStateNormal];
            button.frame = CGRectMake(_leftMargin +i *ITEM_WIDTH +(i)*BUTTON_INTERVAL,20, ITEM_WIDTH, ITEM_HEIGHT);
            [button addTarget:self action:@selector(buttonClick:)];
//            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            [self.scrollView addSubview:button];
            button.tag = 1000+i;

            if (i == self.items.count - 1) {
                self.scrollView.contentInset = UIEdgeInsetsMake(0, _leftMargin, 0, _rightMargin);
                self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(button.frame)+_rightMargin, self.scrollView.height);
            }
        }else
        {
            button.hidden = YES;
            button.tag = 8000;
        }
    }
}

- (void)buttonClick:(SegmentItemView *)button
{
    self.selectedItem.selected = NO;

    button.selected = YES;
    self.selectedItem = button;

//    [UIView animateWithDuration:0.25 animations:^{

        _lineView.centerX = button.centerX;

//    }];

    [self refreshContenOffset];

    if ([_delegate respondsToSelector:@selector(segmentControlViewDidSelectedAtIndex:)]) {
        [_delegate segmentControlViewDidSelectedAtIndex:button.tag - 1000];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    self.selectedItem.selected = NO;

    _currentIndex= currentIndex;

    SegmentItemView *button = [self.scrollView viewWithTag:1000+currentIndex];
    button.selected = YES;
    self.selectedItem = button;

//    [UIView animateWithDuration:0.25 animations:^{

        _lineView.centerX = button.centerX;

//    }];

    [self refreshContenOffset];
}

// 让选中的item位于中间
- (void)refreshContenOffset
{
    CGRect frame = self.selectedItem.frame;
    CGFloat itemX = frame.origin.x;
    CGFloat width = self.scrollView.frame.size.width;
    CGSize contentSize = self.scrollView.contentSize;
//    CGFloat contentSizeWidth =  contentSize.width -(_leftMargin - _rightMargin);
//    contentSize.width = contentSizeWidth;

    if (itemX > width/2) {
        CGFloat targetX;
        if ((contentSize.width-itemX) <= width/2) {
            targetX = contentSize.width - width;
        } else {
            targetX = frame.origin.x - width/2 + frame.size.width/2;
        }
        // 应该有更好的解决方法
        if (targetX + width > contentSize.width) {
            targetX = contentSize.width - width;
        }
        [self.scrollView setContentOffset:CGPointMake(targetX, 0) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}


@end
