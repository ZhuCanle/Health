//
//  HeInformationDetailTopCell.m
//  Health
//
//  Created by 快摇002 on 2017/6/23.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeInformationDetailTopCell.h"
#import "KLTimeTool.h"

@interface HeInformationDetailTopCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *topStateLabel;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;

@end

@implementation HeInformationDetailTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setInformation:(HeInfomationModel *)information
{
    _information = information;
    self.titleLabel.text = information.information_title;
    [self.timeButton setTitle:[KLTimeTool returnDateInterval:information.information_create_time] forState:UIControlStateNormal];
    self.topStateLabel.hidden = (information.information_top_state == 1?NO:YES);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
