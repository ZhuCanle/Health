//
//  HeInfomationEntity.h
//  Health
//
//  Created by 快摇002 on 2017/6/16.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeInfomationEntity : NSObject

/**当前数据的页数*/
@property (assign, nonatomic) NSInteger page;

/**当前频道的数据*/
@property (strong, nonatomic) NSMutableArray<HeInfomationModel *> *infomations;

///**当前的频道index*/
//@property (assign, nonatomic) NSInteger currentIndex;


@end
