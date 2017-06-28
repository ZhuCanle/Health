//
//  SegmentItemView.m
//  Health
//
//  Created by 快摇002 on 2017/6/24.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "SegmentItemView.h"

@interface SegmentItemView ()



@property (nonatomic, weak) id target;
@property (nonatomic) SEL action;

@end

@implementation SegmentItemView

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.itemImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.itemImageView.clipsToBounds = YES;

    @weakify(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        if ([self.target respondsToSelector:self.action]) {
            [self.target performSelector:self.action withObject:self];
        }
    }];
    [self addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (selected) {
        self.titleLabel.textColor = THEME_GREEN;
    }else
    {
        self.titleLabel.textColor = UIColorFromRGB(0x444444);
    }
}

- (void)addTarget:(nullable id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
}

@end
