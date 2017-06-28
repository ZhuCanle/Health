//
//  KLTimeTool.m
//  MealView
//
//  Created by 快摇002 on 16/9/26.
//  Copyright © 2016年 aiitec. All rights reserved.
//

#import "KLTimeTool.h"

@interface KLTimeTool ()

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSTimer *tomorrowTimer;
@property (copy, nonatomic) remind remindBlock;
@property (copy, nonatomic) remind tomorrowRemindBlock;

@end

@implementation KLTimeTool

+ (NSString *)timeWithDate:(NSString *)date
{
    if ([date isEqualToString:@""]|| date == nil) {
        return @"";
    }
    KLTimeTool *tool =  [[KLTimeTool alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [formatter dateFromString:date];

    if ([tool isThisYear:createDate])
    {
        if ([tool isYesterday:createDate])
        {
            formatter.dateFormat = @"昨天 HH:mm";
            date = [formatter stringFromDate:createDate];
        }
        else if ([tool isToday:createDate])//今天
        {
            formatter.dateFormat = @"今天 HH:mm";
            date = [formatter stringFromDate:createDate];
        }
        else if ([tool isBoforeYesterday:createDate])
        {
            formatter.dateFormat = @"前天 HH:mm";
            date = [formatter stringFromDate:createDate];
        }
        else
        {
            formatter.dateFormat = @"MM-dd HH:mm";
            date = [formatter stringFromDate:createDate];
        }
    }
    else //非今年
    {
        //时间格式（XX-XX-XX）
        formatter.dateFormat = @"yyyy-MM-dd";
        date =  [formatter stringFromDate:createDate];
    }
    return date;
}

+ (NSString *)timeWithMessageDate:(NSString *)date
{
    KLTimeTool *tool =  [[KLTimeTool alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [formatter dateFromString:date];

    if ([tool isThisYear:createDate])
    {
        if ([tool isYesterday:createDate])
        {
            formatter.dateFormat = @"昨天 HH:mm";
            date = [formatter stringFromDate:createDate];
        }
        else if ([tool isToday:createDate])//今天
        {
            formatter.dateFormat = @"今天 HH:mm";
            date = [formatter stringFromDate:createDate];
        }
        else if ([tool isBoforeYesterday:createDate])
        {
            formatter.dateFormat = @"前天 HH:mm";
            date = [formatter stringFromDate:createDate];
        }
        else
        {
            formatter.dateFormat = @"MM-dd HH:mm";
            date = [formatter stringFromDate:createDate];
        }
    }
    else //非今年
    {
        //时间格式（XX-XX-XX）
        formatter.dateFormat = @"yyyy-MM-dd";
        date =  [formatter stringFromDate:createDate];
    }
    return date;
}


- (BOOL)isThisYear:(NSDate *)createDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];//日历对象
    NSCalendarUnit unit = NSCalendarUnitYear;//枚举
    NSDateComponents *createComponents = [calendar components:unit fromDate:createDate];
    NSDateComponents *nowCompoents = [calendar components:unit fromDate:[NSDate date]];
    return createComponents.year == nowCompoents.year;
}

- (BOOL)isToday:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *createDate = [formatter dateFromString:[formatter stringFromDate:date]];
    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSCalendar *calendar = [NSCalendar currentCalendar];//日历对象
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;//枚举
    NSDateComponents *intervalCompoents =  [calendar components:unit fromDate:createDate toDate:nowDate options:0];
    return intervalCompoents.year == 0 && intervalCompoents.month == 0 && intervalCompoents.day == 0;
}

- (BOOL)isYesterday:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *createDate = [formatter dateFromString:[formatter stringFromDate:date]];
    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSCalendar *calendar = [NSCalendar currentCalendar];//日历对象
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;//枚举
    NSDateComponents *createComponents = [calendar components:unit fromDate:createDate];
    NSDateComponents *nowCompoents = [calendar components:unit fromDate:nowDate];
    NSDateComponents *intervalCompoents =  [calendar components:unit fromDate:createDate toDate:nowDate options:0];
    return createComponents.year == nowCompoents.year && intervalCompoents.month == 0 && intervalCompoents.day == 1;
}

- (BOOL)isBoforeYesterday:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *createDate = [formatter dateFromString:[formatter stringFromDate:date]];
    NSDate *nowDate = [formatter dateFromString:[formatter stringFromDate:[NSDate date]]];
    NSCalendar *calendar = [NSCalendar currentCalendar];//日历对象
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;//枚举
    NSDateComponents *createComponents = [calendar components:unit fromDate:createDate];
    NSDateComponents *nowCompoents = [calendar components:unit fromDate:nowDate];
    NSDateComponents *intervalCompoents =  [calendar components:unit fromDate:createDate toDate:nowDate options:0];
    return createComponents.year == nowCompoents.year &&intervalCompoents.month == 0&& intervalCompoents.day == 2;
}

+ (NSString *)returnDateInterval:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [formatter dateFromString:dateStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unit fromDate:createDate toDate:[NSDate date] options:0];
    //今年
    //1.今天
    //1分钟内 :刚刚
    //1分钟-59分钟 :XXX分钟前
    //大于60分钟 :XXX小时前
    //
    //昨天
    //昨天 :XX:XX
    //
    //非今年
    //XXXX-XX-XX
    KLTimeTool *tool =  [[KLTimeTool alloc]init];
    if ([tool isThisYear:createDate])
    {
        if ([tool isYesterday:createDate])
        {
//            formatter.dateFormat = @"昨天:HH:mm:ss";
//            return [formatter stringFromDate:createDate];
            formatter.dateFormat = @"MM月dd日";
            return [formatter stringFromDate:createDate];
        }
        else if ([tool isToday:createDate])
        {
            if (components.hour >= 1)
            {
                return [NSString stringWithFormat:@"%ld小时前",(long)components.hour];
            }
            else if (components.minute >= 10)
            {
                return [NSString stringWithFormat:@"%ld分钟前",(long)components.minute];
            }
            else
            {
                return @"刚刚";
            }
        }
        else
        {
            formatter.dateFormat = @"MM月dd日";
            return [formatter stringFromDate:createDate];
        }
    }
    else
    {
        formatter.dateFormat = @"yyyy-MM-dd";
        return [formatter stringFromDate:createDate];
    }
}

@end
