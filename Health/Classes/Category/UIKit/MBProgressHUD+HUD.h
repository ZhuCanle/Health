//
//  MBProgressHUD+HUD.h
//  MBDemo
//
//  Created by Eden_chow on 2017/6/2.
//  Copyright © 2017年 Eden_chow. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (HUD)

/// 默认window上显示 ,`一直显示`
+ (void)showLoading;

/// 默认window上显示 ,time为0 `默认3秒后隐藏`
+ (void)showLoadingWithTime:(NSTimeInterval)time;

/// 如果view转nil,`默认window上显示`
+ (void)showLoadingToView:(UIView *)view;

/// 如果view转nil,`默认window上显示`,time为0 `默认3秒后隐藏`
+ (void)showLoadingToView:(UIView *)view withTime:(NSTimeInterval)time;

/// 显示文字,默认window上显示
+ (void)showText:(NSString *)text;

/// 显示文字,默认window上显示,time为0 `默认1秒后隐藏`
+ (void)showText:(NSString *)text withTime:(NSTimeInterval)time;

/// 隐藏
+ (void)hideLoading;

/// 隐藏
+ (void)hideLoadingToView:(UIView *)view;

@end
