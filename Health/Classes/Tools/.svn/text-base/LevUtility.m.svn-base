//
//  LevUtility.m
//  Levdeo
//
//  Created by 快摇002 on 2017/6/7.
//  Copyright © 2017年 kuka. All rights reserved.
//

#import "LevUtility.h"

#define  KEY_USERNAME_PASSWORD @"com.company.app.usernamepassword"
#define  KEY_USERNAME @"com.company.app.username"
#define  KEY_PASSWORD @"com.company.app.password"

@implementation LevUtility

+ (NSString *)md5:(NSString *)str
{
    if (str.length == 0) {
        return @"";
    }
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    //    CC_MD5(cStr, strlen(cStr), result);//!< 用下面的一行代码替换 [Danny 2014-11-21].
    CC_MD5(cStr, (uint32_t)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)mmd5:(NSString *)str
{
    return [LevUtility md5:[LevUtility md5:str]];
}

+ (NSString *)tokenStringWithPhone:(NSString *)phone;
{
    NSString *string = [NSString stringWithFormat:@"%@%@",phone,[LevUtility getUUID]];
    NSString *md5 = [LevUtility md5:string];
    NSString *mmd5 = [LevUtility md5:md5];
    return mmd5;
}

+ (NSString *)mobilecodeToken
{
    return [self getUUID];
}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [LevUtility getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}


+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)deleteKeyData:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

+(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[LevUtility load:@"com.company.app.usernamepassword"];

    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);

        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));

        //将该uuid保存到keychain
        [LevUtility save:KEY_USERNAME_PASSWORD data:strUUID];

    }
    return strUUID;
}

+ (NSString *)jsonStringWithNSDictionary:(NSDictionary *)dict
{
    NSError *parseError = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)currentVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

@end
