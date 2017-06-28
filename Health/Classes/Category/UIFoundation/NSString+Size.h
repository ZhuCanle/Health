//
//  NSString+Size.h
//  Sasa
//
//  Created by Eden_chow on 2017/5/16.
//  Copyright © 2017年 aiitec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

/**
 *  获取文字size
 */
- (CGSize)sizeOfMaxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize;

- (CGSize)sizeOfMaxSize:(CGSize)maxSize font:(UIFont *)font;

@end
