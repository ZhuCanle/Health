//
//  HeInfomationDetailToolBar.m
//  Health
//
//  Created by 快摇002 on 2017/6/21.
//  Copyright © 2017年 Lamplet. All rights reserved.
//

#import "HeInfomationDetailToolBar.h"

@interface HeInfomationDetailToolBar ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *priaseButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *inputButton;

@end

@implementation HeInfomationDetailToolBar

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.inputTextField.delegate = self;

    self.inputTextField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment"]];
    self.inputTextField.leftView = imageView;
    self.inputTextField.placeholder = @" 评一下";
}

+ (instancetype)toolBar
{
    HeInfomationDetailToolBar *toolBar = [HeInfomationDetailToolBar viewWithXib];
    toolBar.frame = CGRectMake(0, 0, WIDTH, 44);
    return toolBar;
}

- (IBAction)buttomClick:(UIButton*)sender
{
    if (sender == self.backButton) {
        !self.toolBarClickType?:self.toolBarClickType(ToolBarButtonBack);
    }else if (sender == self.priaseButton)
    {
        !self.toolBarClickType?:self.toolBarClickType(ToolBarButtonPriase);
    }else if (sender == self.collectionButton)
    {
        !self.toolBarClickType?:self.toolBarClickType(ToolBarButtonCollection);
    }else if (sender == self.shareButton)
    {
        !self.toolBarClickType?:self.toolBarClickType(ToolBarButtonShare);
    }
    else if (sender == self.inputButton)
    {
        !self.toolBarClickType?:self.toolBarClickType(ToolBarButtonInput);
    }
}

- (void)setModel:(HeInfomationDetaillModel *)model
{
    _model = model;
    self.priaseButton.selected = model.isPriase;
    if (model.infor.information_thump_up_number > 1000) {
        [self.priaseButton setTitle:[NSString stringWithFormat:@" %ldk",(NSInteger)(model.infor.information_thump_up_number*0.001)] forState:UIControlStateNormal];
    }else
    {
        [self.priaseButton setTitle:[NSString stringWithFormat:@" %ld",model.infor.information_thump_up_number] forState:UIControlStateNormal];
    }
    self.collectionButton.selected = model.isCollection;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    !self.inputTextFieldDidBeginEndit ? : self.inputTextFieldDidBeginEndit();
}

@end
