//
//  HeSharePopView.m
//  Health
//
//  Created by 快摇002 on 2017/6/20.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeSharePopView.h"
#import <POP.h>
#import "JXButton.h"

@interface HeSharePopView ()

@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end

@implementation HeSharePopView

+ (instancetype)getSharePopView
{
    HeSharePopView *popView = [HeSharePopView viewWithXib];
    popView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    return popView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];

    @weakify(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        [self dismiss];
    }];
    [self addGestureRecognizer:tap];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];

    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    }completion:^(BOOL finished) {

    }];
    [self addButton];
}


- (void)addButton
{
    NSArray *images = @[@"wx",@"friend",@"sina",@"qq",@"zone",@"other"];
    CGFloat buttonW = 125*0.5;
    CGFloat buttonH = 173*0.5;
    CGFloat edgeMargin = 20;
    CGFloat middleMargin = (WIDTH - 3 *buttonW - 2 *edgeMargin)/2;
    CGFloat startY = (HEIGHT - 2 *buttonH)/2 - HEIGHT;
    NSInteger maxCol = 3;
    for (int i = 0; i < images.count; i ++)
    {
        NSInteger row = i/maxCol;
        NSInteger col = i%maxCol;
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(col *(buttonW +middleMargin)+edgeMargin, row*buttonH +startY +row * 30, buttonW, buttonH);
        [button setImage:[UIImage imageNamed:[images objectAtIndex:i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = 1000+i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:button];

        //添加pop动画
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        //设置起点和终点
        animation.fromValue = [NSValue valueWithCGRect:button.frame];
        CGRect frame = button.frame;
        frame.origin.y += HEIGHT;
        animation.toValue = [NSValue valueWithCGRect:frame];
        //动画开始的时间
        animation.beginTime = CACurrentMediaTime() + i*0.05;
        //设置速度和弹性系数
        animation.springBounciness = 10;
        [button pop_addAnimation:animation forKey:nil];
    }

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, HEIGHT, 93*0.5, 93*0.5);
    [button setImage:[UIImage imageNamed:@"information_share_cannel"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 2000;
    button.centerX = self.centerX;
    [self addSubview:button];
    //添加pop动画
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    //设置起点和终点
    animation.fromValue = [NSValue valueWithCGRect:button.frame];
    CGRect frame = button.frame;
    frame.origin.y -= 120;
    animation.toValue = [NSValue valueWithCGRect:frame];
    //动画开始的时间
    animation.beginTime = CACurrentMediaTime() + 3*0.05;
    //设置速度和弹性系数
    animation.springBounciness = 10;
    [button pop_addAnimation:animation forKey:nil];
}

- (void)cancelWithCompletionBlock:(void(^)())block
{
    for (int i = 6; i >= 0; --i)
    {
        UIButton *button = [self viewWithTag:1000+i];
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        CGRect frame = button.frame;
        animation.fromValue = [NSValue valueWithCGRect:frame];
        frame.origin.y += HEIGHT;
        animation.toValue = [NSValue valueWithCGRect:frame];
        animation.beginTime = CACurrentMediaTime() + (6-i)*.05;
        [button pop_addAnimation:animation forKey:nil];
        if (i == 5) {
            [animation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
                !block ? : block();
            }];
        }
    }
}

- (void)buttonClick:(UIButton *)button
{
    @weakify(self);
    [self cancelWithCompletionBlock:^{
        @strongify(self);
        [self dismiss];
        switch (button.tag - 1000) {
            case 2:{
                break;
            }
            case 1:{

                break;
            }
            case 0:{
                break;
            }
            case 3:{
                break;
            }
            default:
                break;
        }
    }];
}


- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

    [self cancelWithCompletionBlock:^{

    }];
    

}
@end
