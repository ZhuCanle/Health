//
//  HeSquareCommentCell.m
//  Health
//
//  Created by 快摇002 on 2017/6/16.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeSquareCommentCell.h"
#import "KLTimeTool.h"

@interface HeSquareCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *priaseButton;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeightLayoutCon;
@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;

@end

@implementation HeSquareCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HeSquareCommentModel *)model
{
    _model = model;
    self.nameLabel.text = model.critics_user_nickname;
    self.commentLabel.text = model.comment_content;
    [self.userImageView setImageWithURL:[NSURL URLWithString:model.critics_user_head_img] placeholder:[UIImage imageNamed:@""]];
    [self.priaseButton setTitle:[NSString stringWithFormat:@" %ld",model.comment_thump_up_number] forState:UIControlStateNormal];
    self.timeLabel.text = [KLTimeTool returnDateInterval:model.comment_create_time];

    if (stringIsEmpty(model.comment_img)) {
        self.imageViewHeightLayoutCon.constant = 0;

    }else
    {
        self.imageViewHeightLayoutCon.constant = 200;
    }
    [self.commentImageView setImageWithURL:[NSURL URLWithString:model.comment_img] placeholder:[UIImage imageNamed:@""]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
