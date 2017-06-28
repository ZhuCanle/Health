//
//  HeHttpRequestManager.h
//  Health
//
//  Created by 快摇002 on 2017/6/15.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeHttpRequest.h"
#import "HeRespone.h"

typedef void(^HeResponseSuccess)(HeRespone *respone);

typedef void(^HeResponseFail)(NSError *error);

typedef void(^HeDownloadProgress)(int64_t bytesProgress,
int64_t totalBytesProgress);

@interface HeHttpRequestManager : NSObject

+ (instancetype)sharedHttpRequestManager;

+ (void)sendAsynchronousRequest:(HeHttpRequest *)request
                        KeyPath:(NSString *)keyPath
                   successBlock:(HeResponseSuccess)successBlock
                   failureBlock:(HeResponseFail)failureBlock
                       progress:(HeDownloadProgress)progress;

@end
