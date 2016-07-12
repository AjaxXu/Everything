//
//  WDLoginViewController.m
//  Everything
//
//  Created by Louis on 16/7/11.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDLoginViewController.h"
#import "UIView+SDAutoLayout.h"
#import "WDLabelView.h"
#import "WDLoginEditView.h"

@interface WDLoginViewController ()
@property (nonatomic, strong) UIView *registerView;
@property (nonatomic, strong) UIView *loginView;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, strong) WDLoginEditView *phoneView;
@property (nonatomic, strong) WDLoginEditView *authCodeView;
@end

@implementation WDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView
{
    self.title = @"登录/注册";
    
    CGSize viewSize = self.view.frame.size;
    _registerView = [[UIView alloc] initWithFrame:self.view.frame];
    _registerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_registerView];
    
    // 注册提示信息
    WDLabelView *registerInfoView = [[WDLabelView alloc] initWithEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    registerInfoView.label.text = @"请准确填写以下信息";
    [_registerView addSubview:registerInfoView];
    
    // 手机号
    _phoneView = [[WDLoginEditView alloc] initWithEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15) button:nil];
    _phoneView.nameLabel.text = @"手机号";
    _phoneView.inputView.placeholder = @"输入手机号";
    [_registerView addSubview:_phoneView];
    
    // 验证码
    UIButton *authCodeSendButton = [[UIButton alloc] init];
    [authCodeSendButton setTitle:@"获取验证码" forState: UIControlStateNormal];
    [authCodeSendButton setTitleColor:WDThemeColor forState:UIControlStateNormal];
    _authCodeView = [[WDLoginEditView alloc] initWithEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15) button:authCodeSendButton];
    _authCodeView.nameLabel.text = @"验证码";
    _authCodeView.inputView.placeholder = @"输入短信验证码";
    [_registerView addSubview:_authCodeView];
    
    // 注册按钮
    UIButton *registerButton = [UIButton new];
    [registerButton setTitle:@"登录/注册" forState:UIControlStateNormal];
    [registerButton setBackgroundColor:WDThemeColor forState:UIControlStateNormal];
    [registerButton setBackgroundColor:RGB(29, 120, 211) forState:UIControlStateHighlighted];
    [registerButton addTarget:self action:@selector(tapRegisterBtn) forControlEvents:UIControlEventTouchUpInside];
    [_registerView addSubview:registerButton];
    
    // 切换按钮
    UIButton *switchToLoginButton = [[UIButton alloc] init];
    switchToLoginButton.backgroundColor = [UIColor clearColor];
    [switchToLoginButton setTitle:@"用密码登录" forState:UIControlStateNormal];
    [switchToLoginButton setTitleColor:WDThemeColor forState:UIControlStateNormal];
    [switchToLoginButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_registerView addSubview:switchToLoginButton];
    [switchToLoginButton addAction:^(UIButton *btn) {
        [UIView animateWithDuration:0.2 animations:^{
            _registerView.frame = CGRectMake(-viewSize.width, 0, viewSize.width, viewSize.height);
            _loginView.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
        } completion:^(BOOL finished) {
            _registerView.hidden = YES;
        }];
    }];
    
    _loginView = [[UIView alloc] initWithFrame:CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height)];
    _loginView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_loginView];
    
    
    
    
    registerInfoView.sd_layout
    .topSpaceToView(_registerView, 64)
    .leftEqualToView(_registerView)
    .rightEqualToView(_registerView)
    .heightIs(37);
    
    _phoneView.sd_layout
    .topSpaceToView(registerInfoView, 0)
    .leftEqualToView(_registerView)
    .rightEqualToView(_registerView).heightIs(45);
    
    _authCodeView.sd_layout
    .topSpaceToView(_phoneView, 0)
    .leftEqualToView(_registerView)
    .rightEqualToView(_registerView).heightIs(45);
    
    registerButton.sd_layout
    .leftSpaceToView(_registerView, 15)
    .rightSpaceToView(_registerView, 15)
    .topSpaceToView(_authCodeView, 37)
    .heightIs(37);
    
    switchToLoginButton.sd_layout.rightSpaceToView(_registerView, 15).topSpaceToView(registerButton, 20);
    [switchToLoginButton setupAutoSizeWithHorizontalPadding:0 buttonHeight:20];
}

- (void)tapRegisterBtn
{
    
}

@end
