//
//  UIView+ConstraintConstant.h
//  userapp
//
//  Created by 杨智晓 on 15/12/23.
//  Copyright © 2015年 杨智晓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ConstraintConstant)
@property (weak, readonly, nonatomic) NSLayoutConstraint *topConstraint;
@property (weak, readonly, nonatomic) NSLayoutConstraint *bottomConstraint;
@property (weak, readonly, nonatomic) NSLayoutConstraint *leftConstraint;
@property (weak, readonly, nonatomic) NSLayoutConstraint *rightConstraint;
@property (weak, readonly, nonatomic) NSLayoutConstraint *centerXConstraint;
@property (weak, readonly, nonatomic) NSLayoutConstraint *centerYConstraint;
@property (weak, readonly, nonatomic) NSLayoutConstraint *widthConstraint;
@property (weak, readonly, nonatomic) NSLayoutConstraint *heightConstraint;
@end
