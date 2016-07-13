//
//  WDEditNickNameViewController.m
//  Everything
//
//  Created by Louis on 16/7/14.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDEditNickNameViewController.h"

@interface WDEditNickNameViewController ()
@property (nonatomic, strong) UITextField *nameField;
@end

@implementation WDEditNickNameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改名字";
    [self setupView];
    [_nameField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.returnTextBlock != nil)
    {
        self.returnTextBlock(_nameField.text);
    }
}

- (void)setupView
{
    self.view.backgroundColor = RGB(245, 245, 245);
    _nameField = [UITextField new];
    _nameField.font = [UIFont systemFontOfSize:17];
    _nameField.backgroundColor = [UIColor whiteColor];
    _nameField.text = _nickname;
    //    _nameField.textColor = RGB(109, 109, 109);
    [_nameField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.view addSubview: _nameField];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setBackgroundColor:WDThemeColor forState:UIControlStateNormal];
    [saveButton setBackgroundColor:RGB(29, 120, 211) forState:UIControlStateHighlighted];
    [saveButton.layer setMasksToBounds:YES];
    [saveButton.layer setCornerRadius:5.0];
    [self.view addSubview:saveButton];
    [saveButton addAction:^(UIButton *btn) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    _nameField.sd_layout.topSpaceToView(self.view, 74).leftSpaceToView(self.view, 15).rightSpaceToView(self.view, 15).heightIs(38);
    
    saveButton.sd_layout.topSpaceToView(_nameField, 15).leftEqualToView(_nameField).rightEqualToView(_nameField).heightIs(38);
}

- (void)setNickname:(NSString *)nickname
{
    _nickname = nickname;
}

- (void)returnText:(ReturnTextBlock)block
{
    self.returnTextBlock = block;
}

@end
