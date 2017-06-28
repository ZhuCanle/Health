//
//  HeSegmentControlView.h
//  Health
//
//  Created by 快摇002 on 2017/6/15.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentItemView.h"

@protocol HeSegmentControlViewDelegate <NSObject>

- (void)segmentControlViewDidSelectedAtIndex:(NSInteger)index;

@end

@interface HeSegmentControlView : UIView

@property (strong, nonatomic) NSArray *items;

@property (assign, nonatomic) NSInteger currentIndex;

@property (weak, nonatomic) id <HeSegmentControlViewDelegate> delegate;

@end
