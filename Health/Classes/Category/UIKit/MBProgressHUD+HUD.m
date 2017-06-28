//
//  MBProgressHUD+HUD.m
//  MBDemo
//
//  Created by Eden_chow on 2017/6/2.
//  Copyright © 2017年 Eden_chow. All rights reserved.
//

#import "MBProgressHUD+HUD.h"

#define MBHUDDefaultView [[UIApplication sharedApplication]keyWindow]

@implementation MBProgressHUD (HUD)

+ (void)showLoading {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:MBHUDDefaultView animated:YES];

    hud.bezelView.color = [UIColor clearColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.mode = MBProgressHUDModeCustomView;
    
    UIImage *image = [[UIImage imageNamed:@"load"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    
    animation.duration  = 1;
    
    animation.autoreverses = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.repeatCount = MAXFLOAT;
    
    [imageView.layer addAnimation:animation forKey:@"TransformRotationZ"];
    
    hud.customView = imageView;
    hud.square = YES;
    
    [hud setCompletionBlock: ^ {
        [imageView.layer removeAnimationForKey:@"TransformRotationZ"];
    }];
    
}

+ (void)showLoadingWithTime:(NSTimeInterval)time {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:MBHUDDefaultView animated:YES];
    
    hud.bezelView.color = [UIColor clearColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:@"load"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    
    animation.duration  = 1;
    
    animation.autoreverses = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.repeatCount = MAXFLOAT;
    
    [imageView.layer addAnimation:animation forKey:@"TransformRotationZ"];
    
    hud.customView = imageView;
    hud.square = YES;
    if (time == 0) {
        time = 3.0f;
    }
    
    [hud hideAnimated:YES afterDelay:time];
    
    [hud setCompletionBlock: ^ {
        [imageView.layer removeAnimationForKey:@"TransformRotationZ"];
    }];
    
}

+ (void)showLoadingToView:(UIView *)view {
    
    if (view == nil) {
        view = MBHUDDefaultView;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.5];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:@"load"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    
    animation.duration  = 1;
    
    animation.autoreverses = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.repeatCount = MAXFLOAT;
    
    [imageView.layer addAnimation:animation forKey:@"TransformRotationZ"];
    
    hud.customView = imageView;
    hud.square = YES;
    
    [hud setCompletionBlock: ^ {
        [imageView.layer removeAnimationForKey:@"TransformRotationZ"];
    }];

}

+ (void)showLoadingToView:(UIView *)view withTime:(NSTimeInterval)time {

    if (view == nil) {
        view = MBHUDDefaultView;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.bezelView.color = [UIColor clearColor];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:@"load"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    
    animation.duration  = 1;
    
    animation.autoreverses = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.repeatCount = MAXFLOAT;
    
    [imageView.layer addAnimation:animation forKey:@"TransformRotationZ"];
    
    hud.customView = imageView;
    hud.square = YES;
    if (time == 0) {
        time = 3.0f;
    }
    
    [hud hideAnimated:YES afterDelay:time];
    
    [hud setCompletionBlock: ^ {
        [imageView.layer removeAnimationForKey:@"TransformRotationZ"];
    }];

}

+ (void)showText:(NSString *)text {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:MBHUDDefaultView animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.color = [UIColor blackColor];
    hud.margin = 10.0f;
    
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.text = text;
    [label sizeToFit];
    hud.customView = label;
    [hud hideAnimated:YES afterDelay:1.5f];
}


+ (void)showText:(NSString *)text withTime:(NSTimeInterval)time {

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:MBHUDDefaultView animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.color = [UIColor blackColor];
    hud.margin = 10.0f;
    
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.text = text;
    [label sizeToFit];
    hud.customView = label;
    if (time == 0.0) {
        time = 1.f;
    }
    [hud hideAnimated:YES afterDelay:time];
}

+ (void)hideLoading{
    
    [[self HUDForView:MBHUDDefaultView] hideAnimated:YES];
}

+ (void)hideLoadingToView:(UIView *)view {

    [self hideHUDForView:view animated:YES];
}


@end
