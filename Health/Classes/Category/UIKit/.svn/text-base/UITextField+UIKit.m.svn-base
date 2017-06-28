//
//  UITextField+UIKit.m
//  Sasa
//
//  Created by 快摇002 on 2017/4/28.
//  Copyright © 2017年 aiitec. All rights reserved.
//

#import "UITextField+UIKit.h"

@interface UITextField ()

@property (assign, nonatomic) CGFloat leftMargin;
@property (assign, nonatomic) UIColor *holderColor;

@end

@implementation UITextField (UIKit)

- (void)setLeftMargin:(CGFloat)leftMargin;
{
    CGRect frame = self.frame;
    frame.size.width = leftMargin;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    self.holderColor = placeHolderColor;
    [self setValue:placeHolderColor forKeyPath:@"_placeholderLabel.textColor"];
}

- (CGFloat)leftMargin
{
    return self.leftView.width;
}

- (UIColor *)holderColor
{
    return self.holderColor;
}


@end
