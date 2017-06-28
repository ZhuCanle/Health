//
//  Xbox.h
//  Shakecard
//
//  Created by Mac mini  on 15/6/26.
//  Copyright (c) 2015年 Aiitec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "UMSocial.h"

@interface Xbox : UIViewController //<UMSocialUIDelegate>
/** 固定高度,计算Label内容的长度 */
+ (CGRect)labelContenSizeWithWidth:(UILabel *)textLabel;
/** 固定高度,计算Label内容的长度(限长为label的长度) */
+ (CGRect)labelContenSizeWithWidth2:(UILabel *)textLabel;
/** 固定长度,计算Label内容的高度 */
+ (CGRect)labelContenSizeWithHeight:(UILabel *)textLabel;
/** 获取当前日期 */
+ (NSString *)getTimeForNow:(NSDate *)date;
/** 获取当前农历日期 */
+(NSString*)getChineseCalendarWithDate:(NSDate *)date;
/** 颜色转图片 */
+ (UIImage *)createImageWithColor:(UIColor *)color;
/**
 * 按照拼音首字母分组;
 * @bref items为所有带有拼音字段的数组;
 */
//+ (NSArray *)sortedPinyin:(AIIItemCollection *)items;

/**
 * 小写字母转换成大写字母;
 * @bref pinyinArray小写字母数组;
 */
+ (NSArray *)convertCapital:(NSArray *)pinyinArray;

/** 调整图片方向 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

+ (NSString *)getBeijingDate;

/** 只取日期部分 */
+ (NSString *)substringTodayDate;


@end
