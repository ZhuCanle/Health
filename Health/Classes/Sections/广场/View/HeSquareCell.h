//
//  HeSquareCell.h
//  Health
//
//  Created by 快摇002 on 2017/6/16.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeImagesView.h"

@interface HeSquareCell : UITableViewCell

@property (strong, nonatomic) HeSquareModel *model;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagesViewHeightLayoutCon;

@end
