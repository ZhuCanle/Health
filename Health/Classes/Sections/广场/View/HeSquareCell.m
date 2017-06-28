//
//  HeSquareCell.m
//  Health
//
//  Created by 快摇002 on 2017/6/16.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeSquareCell.h"
#import "KLTimeTool.h"
#import "HeImagesView.h"

@interface HeSquareCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;
@property (weak, nonatomic) IBOutlet HeImagesView *imagesContentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLayoutCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayoutCon;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imagesViewWitdhLayoutCon;

@end

@implementation HeSquareCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(HeSquareModel *)model
{
    _model = model;
    self.nameLabel.text = model.user_nickname;
    self.commentTitleLabel.text = model.posts_title;
    self.commentContentLabel.text = model.posts_content;
    [self.userImageView setImageWithURL:[NSURL URLWithString:model.user_head_img] placeholder:[UIImage imageNamed:@""]];
    self.timeLabel.text = [KLTimeTool returnDateInterval:model.posts_create_time];

    self.imagesContentView.images = model.posts_img;
    CGSize size = [HeImagesView imgaesViewSizeWith:model.posts_img];
//    self.imagesViewWitdhLayoutCon.constant = size.width;
    self.imagesViewHeightLayoutCon.constant = size.height;

    NSLog(@"有%ld张图片-----%@",model.posts_img.count,NSStringFromCGSize(size));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
