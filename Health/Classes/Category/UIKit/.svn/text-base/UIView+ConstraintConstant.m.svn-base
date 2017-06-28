//
//  UIView+ConstraintConstant.m
//  userapp
//
//  Created by 杨智晓 on 15/12/23.
//  Copyright © 2015年 杨智晓. All rights reserved.
//

#import "UIView+ConstraintConstant.h"

@implementation UIView (ConstraintConstant)

- (NSLayoutConstraint *)constraintWithAttr:(NSLayoutAttribute)attr {
    __block NSLayoutConstraint *targetConstraint = nil;
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstAttribute == attr) {
            targetConstraint = obj;
            *stop = YES;
        }
    }];
    return targetConstraint;
}

- (NSLayoutConstraint *)parentConstraintWithAttr:(NSLayoutAttribute)attr {
    UIView *view = self;
    __block NSLayoutConstraint *targetConstraint = nil;
    [self.superview.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ((obj.firstAttribute == attr && obj.firstItem == view)
            ||
            (obj.secondAttribute == attr && obj.secondItem == view))
        {
            targetConstraint = obj;
            *stop = YES;
        }
    }];
    return targetConstraint;
}

#pragma mark - setter and getter

- (NSLayoutConstraint *)topConstraint {
    return [self parentConstraintWithAttr:NSLayoutAttributeTop];
}

- (NSLayoutConstraint *)bottomConstraint {
    return [self parentConstraintWithAttr:NSLayoutAttributeBottom];
}

- (NSLayoutConstraint *)leftConstraint {
    return [self parentConstraintWithAttr:NSLayoutAttributeLeading];
}

- (NSLayoutConstraint *)rightConstraint {
    return [self parentConstraintWithAttr:NSLayoutAttributeTrailing];
}

- (NSLayoutConstraint *)centerXConstraint {
    return [self parentConstraintWithAttr:NSLayoutAttributeCenterX];
}

- (NSLayoutConstraint *)centerYConstraint {
    return [self parentConstraintWithAttr:NSLayoutAttributeCenterY];
}

- (NSLayoutConstraint *)widthConstraint {
    return [self constraintWithAttr:NSLayoutAttributeWidth];
}

- (NSLayoutConstraint *)heightConstraint {
    return [self constraintWithAttr:NSLayoutAttributeHeight];
}

@end
