//
//  NSString+Size.m
//  Sasa
//
//  Created by Eden_chow on 2017/5/16.
//  Copyright © 2017年 aiitec. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

//计算文本的大小
- (CGSize)sizeOfMaxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize {
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}


- (CGSize)sizeOfMaxSize:(CGSize)maxSize font:(UIFont *)font {
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}
@end
