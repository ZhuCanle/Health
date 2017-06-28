//
//  HeBaseTabBarViewController.m
//  Health
//
//  Created by 快摇002 on 2017/6/13.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeBaseTabBarViewController.h"
#import "HeBaseNavigationViewController.h"
#import "HeInformationViewController.h"
#import "HeSquareViewController.h"
#import "HeCenterViewController.h"
#import "HeCustomerServiceViewController.h"
#import "HeMineViewController.h"

@interface HeBaseTabBarViewController ()

@end

@implementation HeBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = UIColorFromRGB(0x444444);

    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = THEME_GREEN;

    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    [self setChildViewControllerWith:[[HeInformationViewController alloc]init] :
     @"资讯" :
     @"common_icon_news_normal" :
     @"common_icon_news_selected"];

    [self setChildViewControllerWith:[[HeSquareViewController  alloc]init] :
     @"广场" :
     @"common_icon_square_normal" :
     @"common_icon_square_selected"];

    [self setChildViewControllerWith:[[HeCenterViewController alloc]init] :
     @"" :
     @"common_icon_add_normal" :
     @"common_icon_add_selected"];

    [self setChildViewControllerWith:[[HeCustomerServiceViewController alloc]init] :
     @"客服" :
     @"common_icon_service_normal" :
     @"common_icon_service_selected"];

    [self setChildViewControllerWith:[[HeMineViewController alloc]init] :
     @"我的" :
     @"common_icon_my_normal" :
     @"common_icon_my_selected"];

    self.tabBar.barTintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)setChildViewControllerWith:(UIViewController *)viewController :
                                                    (NSString *)title :
                                                    (NSString *)image :
                                                    (NSString *)selectedImage {
    HeBaseNavigationViewController *navigation = [[HeBaseNavigationViewController alloc]initWithRootViewController:viewController];
    viewController.navigationItem.title = title;
    navigation.tabBarItem.title = title;
    //特殊处理中间加号按钮的图片位置
    if ([viewController isKindOfClass:[HeCenterViewController class]]) {
        navigation.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    }
    navigation.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigation.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:navigation];
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
