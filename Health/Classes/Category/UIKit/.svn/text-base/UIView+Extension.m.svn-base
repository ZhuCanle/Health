//
//  UIView+Extension.m
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"

#import <objc/runtime.h>

static const void *MaskCountKey = &MaskCountKey;
static const void *RefleshCountKey = &RefleshCountKey;
static const void *KeepObjectKey = &KeepObjectKey;

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (NSInteger)maskCount {
    return [objc_getAssociatedObject(self, MaskCountKey) unsignedIntegerValue];
}

- (void)setMaskCount:(NSInteger)maskCount {
    objc_setAssociatedObject(self, MaskCountKey, [NSNumber numberWithUnsignedInteger:maskCount], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)refleshCount {
    return [objc_getAssociatedObject(self, RefleshCountKey) unsignedIntegerValue];
}

- (void)setRefleshCount:(NSInteger)refleshCount {
    objc_setAssociatedObject(self, RefleshCountKey, [NSNumber numberWithUnsignedInteger:refleshCount], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.masksToBounds = cornerRadius > 0;
    self.layer.cornerRadius = cornerRadius;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (id)keepObject {
    return objc_getAssociatedObject(self, KeepObjectKey);
}

- (void)setKeepObject:(id)keepObject {
    objc_setAssociatedObject(self, KeepObjectKey, keepObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

+ (instancetype)viewWithXib
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:self options:nil]lastObject];
}

@end
