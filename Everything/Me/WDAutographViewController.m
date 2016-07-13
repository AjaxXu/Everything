//
//  WDAutographViewController.m
//  Everything
//
//  Created by Louis on 16/7/14.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDAutographViewController.h"

@interface WDAutographViewController ()

@property (nonatomic, strong) UITextView *autographView;

@end

@implementation WDAutographViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个性签名";
    [self setupView];
    [_autographView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.returnTextBlock != nil)
    {
        self.returnTextBlock(_autographView.text);
    }
}

- (void)setupView
{
    self.view.backgroundColor = RGB(245, 245, 245);
    self.automaticallyAdjustsScrollViewInsets = false;
    _autographView = [UITextView new];
    _autographView.font = [UIFont systemFontOfSize:17];
    _autographView.backgroundColor = [UIColor whiteColor];
    _autographView.text = _autograph;
    //    _autographView.textColor = RGB(109, 109, 109);
    [self.view addSubview: _autographView];
    
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
    
    _autographView.sd_layout.topSpaceToView(self.view, 74).leftSpaceToView(self.view, 15).rightSpaceToView(self.view, 15).heightIs(80);
    
    saveButton.sd_layout.topSpaceToView(_autographView, 15).leftEqualToView(_autographView).rightEqualToView(_autographView).heightIs(38);
}

- (void)setAutograph:(NSString *)autograph
{
    _autograph = autograph;
}

- (void)returnText:(ReturnTextBlock)block
{
    self.returnTextBlock = block;
}

@end
