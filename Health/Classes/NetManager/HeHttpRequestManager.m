//
//  HeHttpRequestManager.m
//  Health
//
//  Created by 快摇002 on 2017/6/15.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeHttpRequestManager.h"
#import "LevUtility.h"

static NSMutableArray *tasks;

@implementation HeHttpRequestManager

+ (instancetype)sharedHttpRequestManager
{
    static id httpRequestManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpRequestManager = [[super allocWithZone:NULL] init];
    });
    return httpRequestManager;
}

+ (void)sendAsynchronousRequest:(HeHttpRequest *)request
                        KeyPath:(NSString *)keyPath
                   successBlock:(HeResponseSuccess)successBlock
                   failureBlock:(HeResponseFail)failureBlock
                       progress:(HeDownloadProgress)progress
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/xml", @"text/plain", @"application/javascript", @"image/*", nil];

    if (stringIsEmpty(request.sign)) {
        [MBProgressHUD showText:@"签名为空" withTime:1.5];
        return;
    }

    if (stringIsEmpty(request.sign)) {
        [MBProgressHUD showText:@"签名为空" withTime:1.5];
        return;
    }

    if (!request.data) {
        [MBProgressHUD showText:@"请求参数为空" withTime:1.5];
        return;
    }

    HeRequestEntity *data = request.data;
    NSString *json =  [data modelToJSONString];

    NSMutableString *clearJson = [NSMutableString stringWithString:json];
    NSString *character = nil;
    for (int i = 0; i < clearJson.length; i ++) {
        character = [clearJson substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"])
            [clearJson deleteCharactersInRange:NSMakeRange(i, 1)];
    }

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:request.sign forKey:@"sign"];
    [parameters setValue:clearJson forKey:@"data"];

    NSLog(@"POST 请求地址 :%@",GET_REQUEST_PATH(keyPath));
    NSLog(@"请求携带参数 requst = %@",parameters);

    [manager POST:GET_REQUEST_PATH(keyPath) parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress)
     {
         if (progress) {
             progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
         }

     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary *dict = responseObject;
         NSDictionary  *dataDict = [dict objectForKey:@"data"];
         HeRespone *respone = [[HeRespone alloc]init];
         respone.data = dataDict;
         respone.state = [[dict valueForKey:@"state"] integerValue];

         //对于有一些协议接口没有data返回字典
         respone.responeObject = dict;

         NSLog(@"respone = %@",[LevUtility jsonStringWithNSDictionary:dict]);

         if (successBlock) {
             successBlock(respone);
         }
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [MBProgressHUD  showText:error.localizedDescription withTime:1.5];
         NSLog(@"error = %@ ==== %@",error.description,[error localizedDescription]);
         if (failureBlock) {
             failureBlock(error);
         }
     }];
}


@end
