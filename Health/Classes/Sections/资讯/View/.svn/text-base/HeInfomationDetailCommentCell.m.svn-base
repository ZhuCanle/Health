//
//  HeInfomationDetailCommentCell.m
//  Health
//
//  Created by 快摇002 on 2017/6/21.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeInfomationDetailCommentCell.h"

@interface HeInfomationDetailCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentImageViewHeightLayoutCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentImageViewWitdhLayoutCon;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *priaseButton;

@property (strong, nonatomic) UIImageView *subImageView;

@end

@implementation HeInfomationDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.commentImageView addSubview:self.subImageView];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setComment:(HeSquareCommentModel *)comment
{
    _comment = comment;

    [self.userImageView setImageWithURL:[NSURL URLWithString:comment.critics_user_head_img] placeholder:nil];

    self.nameLabel.text = comment.critics_user_nickname;

    if (self.comment.by_critics_user_nickname.length != 0)
    {//评论别人的评论
        NSString *text = @"";
        if (comment.quote_comment_img.length > 0) {
            text = [NSString stringWithFormat:@"%@ [图片]",comment.	quote_comment_content];
        }else
        {
            text = [NSString stringWithFormat:@"%@",comment.	quote_comment_content];
        }
        NSString * content = [NSString stringWithFormat:@"%@ |回复 %@ :%@",comment.comment_content,comment.by_critics_user_nickname,text];

        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:content attributes:@{NSForegroundColorAttributeName :UIColorFromRGB(0x333333)}];
        NSRange range = [content rangeOfString:comment.by_critics_user_nickname];
        [attri addAttribute:NSForegroundColorAttributeName value:THEME_GREEN range:range];
        NSRange rangeText = [content rangeOfString:text];
        [attri addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x666666) range:rangeText];
        self.commentContentLabel.attributedText = attri;
    }else
    {
        self.commentContentLabel.text = comment.comment_content;
    }

    if (comment.comment_thump_up_number > 1000) {
        [self.priaseButton setTitle:[NSString stringWithFormat:@" %ldk",(NSInteger)(comment.comment_thump_up_number*0.001)] forState:UIControlStateNormal];
    }else
    {
        [self.priaseButton setTitle:[NSString stringWithFormat:@" %ld",comment.comment_thump_up_number] forState:UIControlStateNormal];
    }

//    [self.priaseButton setTitle:[NSString stringWithFormat:@"% ld",comment.comment_thump_up_number] forState:UIControlStateNormal];
//    self.commentImageView.backgroundColor = [UIColor redColor];

    if (comment.isPrase == 1) {
        self.priaseButton.selected = YES;
    }else
    {
        self.priaseButton.selected = NO;
    }

    if (stringIsEmpty(comment.comment_app_img.img))
    {
        self.commentImageViewHeightLayoutCon.constant = 0;
        self.commentImageViewWitdhLayoutCon.constant = 0;
        self.commentImageView.hidden = YES;
        self.imageView.image = nil;
    }else{

        CGFloat width = self.comment.comment_app_img.width;
        CGFloat height = self.comment.comment_app_img.height;
        if (width > WIDTH - 30)
        {
            //缩放
            CGFloat imageHeight = WIDTH *height/width;

            self.commentImageViewHeightLayoutCon.constant = imageHeight;
            self.commentImageViewWitdhLayoutCon.constant = WIDTH - 30;

            self.subImageView.frame = CGRectMake(0, 15,  WIDTH - 30, imageHeight);
        }else
        {
            self.commentImageViewHeightLayoutCon.constant = height;
            self.commentImageViewWitdhLayoutCon.constant = width;

            self.subImageView.frame = CGRectMake(0, 0,  width, height);
        }
        self.commentImageView.hidden = NO;
        [self.commentImageView setImageWithURL:[NSURL URLWithString:comment.comment_app_img.img] placeholder:[UIImage imageNamed:@"loading"]];
    }
}

- (void)setLevelString:(NSString *)levelString
{
    _levelString = levelString;
    self.levelLabel.text = levelString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (UIImageView *)subImageView
{
    if (_subImageView == nil) {
        _subImageView = [[UIImageView alloc]init];
    }
    return _subImageView;
}

- (IBAction)postComment:(id)sender
{
    !self.commentCellDidClick ? : self.commentCellDidClick(0);
}
- (IBAction)priaseButtonClick:(id)sender {

    !self.commentCellDidClick ? : self.commentCellDidClick(1);
}

@end
