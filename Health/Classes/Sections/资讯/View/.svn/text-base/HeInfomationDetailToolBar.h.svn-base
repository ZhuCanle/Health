//
//  HeInfomationDetailToolBar.h
//  Health
//
//  Created by 快摇002 on 2017/6/21.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ToolBarButtonType) {
    ToolBarButtonBack,
    ToolBarButtonPriase,
    ToolBarButtonCollection,
    ToolBarButtonShare,
    ToolBarButtonInput,
};

@interface HeInfomationDetailToolBar : UIView

+ (instancetype)toolBar;

@property (copy, nonatomic) void(^toolBarClickType)(ToolBarButtonType);

@property (copy, nonatomic) void(^inputTextFieldDidBeginEndit)();

@property (strong, nonatomic) HeInfomationDetaillModel *model;

@end
