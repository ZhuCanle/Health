//
//  AppConfig.h
//  Health
//
//  Created by 快摇002 on 2017/6/13.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#if DEBUG

    #define DOMAIN_PATH                 @"http://182.92.102.79/"
    #define GET_REQUEST_PATH(sufix)     [NSString stringWithFormat:@"%@%@",DOMAIN_PATH,sufix]


#else

    #define DOMAIN_PATH                 @"http://182.92.102.79/"
    #define GET_REQUEST_PATH(sufix)     [NSString stringWithFormat:@"%@%@",DOMAIN_PATH,sufix]


#endif


#pragma mark - 颜色

    #define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:1.0]

    #define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

    /** 主题绿 */
    #define THEME_GREEN [UIColor colorWithRed:109/255.0 green:231/255.0 blue:172/255.0 alpha:1]


#pragma mark - 尺寸

    #define WIDTH   [UIScreen mainScreen].bounds.size.width
    #define HEIGHT  [UIScreen mainScreen].bounds.size.height



























