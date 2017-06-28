//
//  HePostCommentView.h
//  Health
//
//  Created by 快摇002 on 2017/6/23.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PostCommentButtonType) {
    PostCommentButtonSend,
    ToolBarButtonPhoto,
};

typedef void(^commentViewDidmissBlock)();

@interface HePostCommentView : UIView

@property (assign, nonatomic) CGFloat contenty;

- (void)dismissWithCallBlock:(commentViewDidmissBlock)block;

@property (copy, nonatomic) void(^postCommentViewClick)(PostCommentButtonType);

@property (strong, nonatomic) UIImage *image;

@property (copy, nonatomic) NSString *text;

+ (instancetype)commentView;

- (void)showInView:(UIView *)view;


@end
