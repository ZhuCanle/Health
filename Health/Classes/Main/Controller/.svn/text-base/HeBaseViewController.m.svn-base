//
//  HeBaseViewController.m
//  Health
//
//  Created by 快摇002 on 2017/6/13.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeBaseViewController.h"

@interface HeBaseViewController ()

@end

@implementation HeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)dealloc
{
    NSString *className = [NSString stringWithCString:object_getClassName(self) encoding:NSUTF8StringEncoding];
    NSLog(@"Dealloc - %@", className);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


//设置透明状态
- (void)setClearNavigationBarStatus
{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    // 将状态栏和导航条设置成透明
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];

    self.navigationController.navigationBar.titleTextAttributes =  @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

//设置白色状态条
- (void)setGreenNavigationBarStatus
{
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x66de90);
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.titleTextAttributes =  @{NSForegroundColorAttributeName:[UIColor whiteColor]};

    UIImageView *navBarHairlineImageView;
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    navBarHairlineImageView.hidden = YES;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
