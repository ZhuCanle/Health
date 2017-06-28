//
//  HePostCommentView.m
//  Health
//
//  Created by 快摇002 on 2017/6/23.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HePostCommentView.h"

@interface HePostCommentView ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottonLayoutCon;

@end

@implementation HePostCommentView

-(void)awakeFromNib
{
    [super awakeFromNib];

    @weakify(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        [self dismissWithCallBlock:nil];
    }];
    [self.backgroundView addGestureRecognizer:tap];

    self.textView.delegate = self;
}

+ (instancetype)commentView;
{
    HePostCommentView *view = [HePostCommentView viewWithXib];
    view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    return view;
}

- (void)showInView:(UIView *)view
{
    self.textView.text = @"";
    self.image = nil;
    [self.photoButton setImage:[UIImage imageNamed:@"fk_photo"] forState:UIControlStateNormal];

    [view addSubview:self];
    [self.textView becomeFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:.7];
    }];
}

- (void)setContenty:(CGFloat)contenty
{
//    self.contentViewBottonLayoutCon.constant  = contenty;
//    [self layoutIfNeeded];
}

- (void)dismissWithCallBlock:(commentViewDidmissBlock)block
{
//    self.contentViewBottonLayoutCon.constant = 0;

    [self endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (block) {
            block();
        }
    }];
}

- (IBAction)sendButtonClick:(id)sender {
    if (stringIsEmpty(self.textView.text)) {
        [MBProgressHUD showText:@"请输入评论内容" withTime:1.5];
        return;
    }
    !self.postCommentViewClick?: self.postCommentViewClick(PostCommentButtonSend);
}

- (IBAction)photoButtonClick:(id)sender {
    !self.postCommentViewClick?: self.postCommentViewClick(ToolBarButtonPhoto);
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self.photoButton setImage:image forState:UIControlStateNormal];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
//    [self removeFromSuperview];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.text = textView.text;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
