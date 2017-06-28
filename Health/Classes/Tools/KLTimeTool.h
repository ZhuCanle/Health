//
//  KLTimeTool.h
//  MealView
//
//  Created by 快摇002 on 16/9/26.
//  Copyright © 2016年 aiitec. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^remind) ();

@interface KLTimeTool : NSObject

+ (NSString *)timeWithDate:(NSString *)date;

+ (NSString *)timeWithMessageDate:(NSString *)date;

+ (NSString *)returnDateInterval:(NSString *)dateStr;

@end
