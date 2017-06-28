//
//  HeInfomationCell.m
//  Health
//
//  Created by 快摇002 on 2017/6/14.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeInfomationCell.h"
#import "KLTimeTool.h"
#import <TTGTagCollectionView.h>

@interface HeInfomationCell ()<TTGTagCollectionViewDelegate, TTGTagCollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *infoImageView;
@property (weak, nonatomic) IBOutlet UIButton *priaseButton;
@property (weak, nonatomic) IBOutlet TTGTagCollectionView *tagContentView;

@property (strong, nonatomic) NSMutableArray <UILabel *> *tagViews;


@end

@implementation HeInfomationCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _tagViews = @[].mutableCopy;

    [self.infoImageView setLayoutWithCornerRadius:3 borderColor:nil borderWidth:0];
    self.infoImageView.contentMode = UIViewContentModeScaleAspectFill;

    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.tagContentView.dataSource = self;
    self.tagContentView.delegate = self;
    self.tagContentView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tagContentView.horizontalSpacing = 5;
    self.tagContentView.verticalSpacing = 5;
    self.tagContentView.scrollView.scrollEnabled = NO;
}

- (void)setInfomation:(HeInfomationModel *)infomation
{
    self.titleLabel.text = infomation.information_title;
    self.timeLabel.text = [KLTimeTool returnDateInterval:infomation.information_create_time];
    [self.infoImageView setImageWithURL:[NSURL URLWithString:infomation.information_img_address] placeholder:[UIImage imageNamed:@""]];

    if (infomation.information_thump_up_number > 1000) {
        [self.priaseButton setTitle:[NSString stringWithFormat:@"%ldk",infomation.information_thump_up_number/1000] forState:UIControlStateNormal];
    }else
    {
        [self.priaseButton setTitle:[NSString stringWithFormat:@"%ld",infomation.information_thump_up_number] forState:UIControlStateNormal];
    }

    NSString *label_Name = @"";
    if (infomation.information_top_state == 1)
    {
        label_Name = [NSString stringWithFormat:@"置顶,%@",infomation.label_name];
    }else
    {
        label_Name = infomation.label_name;
    }
    NSArray *titles = [label_Name componentsSeparatedByString:@","];

    [self.tagViews removeAllObjects];

    for (NSInteger i = 0; i < titles.count; i++) {
        NSString *name = titles[i];
        if (![name isEqualToString:@"(null)"]) {
            [_tagViews addObject:[self bulidLabelWithTitle:titles[i] withTag:i]];
        }
    }
    [self.tagContentView reload];
}

- (CGSize)tagCollectionView:(TTGTagCollectionView *)tagCollectionView sizeForTagAtIndex:(NSUInteger)index {
    return _tagViews[index].frame.size;
}

#pragma mark - TTGTagCollectionViewDataSource

- (NSUInteger)numberOfTagsInTagCollectionView:(TTGTagCollectionView *)tagCollectionView {
    return _tagViews.count;
}

- (UIView *)tagCollectionView:(TTGTagCollectionView *)tagCollectionView tagViewForIndex:(NSUInteger)index {
    return _tagViews[index];
}

- (UILabel *)bulidLabelWithTitle:(NSString *)title withTag:(NSInteger)tag{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:11.0f];
    label.tag = tag;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    [label sizeToFit];
    label.height = 12;
    label.width += 10;

    if ([title isEqualToString:@"置顶"]) {
        [label setLayoutWithCornerRadius:2.5 borderColor:THEME_GREEN borderWidth:1];
        label.textColor = THEME_GREEN;
    }else if ([title isEqualToString:@"健康"])
    {
        [label setLayoutWithCornerRadius:2.5 borderColor:UIColorFromRGB(0xffcc33) borderWidth:1];
        label.textColor = UIColorFromRGB(0xffcc33);
    }else
    {
        [label setLayoutWithCornerRadius:2.5 borderColor: UIColorFromRGB(0x999999) borderWidth:1];
        label.textColor = UIColorFromRGB(0x999999);
    }
    return label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
