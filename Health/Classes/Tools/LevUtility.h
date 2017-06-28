//
//  LevUtility.h
//  Levdeo
//
//  Created by 快摇002 on 2017/6/7.
//  Copyright © 2017年 kuka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface LevUtility : NSObject

/**
 *  @brief  32位MD5加密.
 *
 *  @param str 需要md5加密的字符串.
 */
+ (NSString *)md5:(NSString *)str;

/**
 *  @brief  32位双层MD5加密.
 *
 *  @param str 需要mmd5加密的字符串.
 */
+ (NSString *)mmd5:(NSString *)str;

/**
 *  @brief  获取token.
 */
+ (NSString *)tokenStringWithPhone:(NSString *)phone;

/**
 *  @brief  手机唯一标识
 */
+ (NSString *)mobilecodeToken;

/**
 *  @brief  获取字典转json.
 */
+ (NSString *)jsonStringWithNSDictionary:(NSDictionary *)dict;

// 获取当前版本号
+ (NSString *)currentVersion;


+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)deleteKeyData:(NSString *)service;

@end
