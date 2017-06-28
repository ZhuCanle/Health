//
//  Xbox.m
//  Shakecard
//
//  Created by Mac mini  on 15/6/26.
//  Copyright (c) 2015年 Aiitec. All rights reserved.
//

#import "Xbox.h"

@interface Xbox ()

@end

@implementation Xbox

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/** 限长 250 */
+ (CGRect)labelContenSizeWithWidth:(UILabel *)textLabel {
    NSDictionary *dct = [NSDictionary dictionaryWithObjectsAndKeys:textLabel.font,NSFontAttributeName, nil];
    CGRect rect = [textLabel.text boundingRectWithSize:CGSizeMake(250, textLabel.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dct context:nil];
    rect.origin.y = textLabel.frame.origin.y;
    rect.origin.x = textLabel.frame.origin.x;
    rect.size.height = textLabel.frame.size.height;
    return rect;
}

/** 限长为label的长度 */
+ (CGRect)labelContenSizeWithWidth2:(UILabel *)textLabel {
    NSDictionary *dct = [NSDictionary dictionaryWithObjectsAndKeys:textLabel.font,NSFontAttributeName, nil];
    CGRect rect = [textLabel.text boundingRectWithSize:CGSizeMake(textLabel.frame.size.width, textLabel.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dct context:nil];
    rect.origin.y = textLabel.frame.origin.y;
    rect.origin.x = textLabel.frame.origin.x;
    rect.size.height = textLabel.frame.size.height;
    return rect;
}

+ (CGRect)labelContenSizeWithHeight:(UILabel *)textLabel {
    NSDictionary *dct = [NSDictionary dictionaryWithObjectsAndKeys:textLabel.font,NSFontAttributeName, nil];
    CGRect rect = [textLabel.text boundingRectWithSize:CGSizeMake(textLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dct context:nil];
    rect.origin.y = textLabel.frame.origin.y;
    rect.origin.x = textLabel.frame.origin.x;
    rect.size.width = textLabel.frame.size.width;
    return rect;
}

/// 颜色转换成图片
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/// 获取当前日期
+ (NSString *)getTimeForNow:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

/// 获取当前农历日期
+(NSString*)getChineseCalendarWithDate:(NSDate *)date {
    
    //    NSArray *chineseYears = [NSArray arrayWithObjects:
    //                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
    //                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
    //                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
    //                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
    //                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
    //                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    //    NSLog(@"%d_%d_%d  %@",localeComp.year,localeComp.month,localeComp.day, localeComp.date);
    
    //    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"农历%@%@",m_str,d_str];
    
    return chineseCal_str;  
}

//+ (NSArray *)sortedPinyin:(AIIItemCollection *)items {
//    NSMutableArray *pinyinArray = [NSMutableArray array];
//    for (AIIItem *item in items) {
//        NSString *firstWord = [item.pinyin substringToIndex:1];
//        if (![pinyinArray containsObject:firstWord]) {
//            [pinyinArray addObject:firstWord];
//        }
//    }
//    
//    [pinyinArray sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
//        NSString *word = (NSString *)obj1;
//        NSString *word2 = (NSString *)obj2;
//        char ch = [word characterAtIndex:0];
//        char ch2 = [word2 characterAtIndex:0];
//        if (ch > ch2) {
//            return NSOrderedDescending;
//        }
//        else {
//            return NSOrderedAscending;
//        }
//    }];
//    
//    NSMutableArray *dataSource = [NSMutableArray array];
//    for (NSString *firstWord in pinyinArray) {
//        NSMutableArray *sameFirstWordArray = [NSMutableArray array];
//        for (AIIItem *item in items) {
//            NSString *firstWord2 = [item.pinyin substringToIndex:1];
//            if ([firstWord isEqual:firstWord2]) {
//                [sameFirstWordArray addObject:item];
//            }
//        }
//        
//        [dataSource addObject:sameFirstWordArray];
//    }
//    
//    return dataSource;
//}

+ (NSArray *)convertCapital:(NSArray *)pinyinArray {
    NSMutableArray *capitalArray = [NSMutableArray array];
    for (NSString *word in pinyinArray) {
        if (word.length == 1) {
            char ch = [word characterAtIndex:0];
            char ch2 = ch - 32;
            NSString *capital = [NSString stringWithFormat:@"%c",ch2];
            [capitalArray addObject:capital];
        }
    }

    return capitalArray;
}

/// 调整图片方向
+ (UIImage *)fixOrientation:(UIImage *)aImage
{
    if (aImage==nil || !aImage) {
        return nil;
    }
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp) return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    UIImageOrientation orientation=aImage.imageOrientation;
    int orientation_=orientation;
    switch (orientation_) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
    switch (orientation_) {
        case UIImageOrientationUpMirrored:{
            
        }
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    aImage=img;
    
    img=nil;
    return aImage;
}

+ (NSString *)getBeijingDate{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *lastDay = [dateformatter
                         stringFromDate:today];
    
    NSDate *date = [dateformatter dateFromString:lastDay];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    localeDate = [localeDate dateByAddingTimeInterval:360];
    //    NSLog(@"locationString:%@",localeDate);
    NSString *string = [dateformatter stringFromDate:localeDate];
    //    return lastDay;
    return string;
}

//!<只取日期部分. 用于发货提醒对比
+ (NSString *)substringTodayDate{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *lastDay = [dateformatter
                         stringFromDate:today];
    
    NSDate *date = [dateformatter dateFromString:lastDay];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    localeDate = [localeDate dateByAddingTimeInterval:360];
    NSString *string = [dateformatter stringFromDate:localeDate];
    
    return string;
}

@end
