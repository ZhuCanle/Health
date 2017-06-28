//
//  HeInfomationModel.m
//  Health
//
//  Created by 快摇002 on 2017/6/15.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeInfomationModel.h"

@implementation HeInfomationModel


- (NSString *)label_name
{
    if ([_label_name isEqualToString:@"(null)"]) {
        return @"";
    }else
    {
        return _label_name;
    }
}



@end
