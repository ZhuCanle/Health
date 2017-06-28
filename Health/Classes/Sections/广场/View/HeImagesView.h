//
//  HeImagesView.h
//  Health
//
//  Created by 快摇002 on 2017/6/18.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeImageModel.h"

@interface HeImagesView : UIView

@property (strong, nonatomic) NSMutableArray<HeImageModel *> *images;
+ (CGSize)imgaesViewSizeWith:(NSMutableArray <HeImageModel *>*)images;

@end
