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
#import "CocoaSecurity.h"

@interface WDLoginViewController ()
@property (nonatomic, strong) UIView *registerView;
@property (nonatomic, strong) UIView *loginView;
@property (nonatomic, assign) NSUInteger currentIndex;
@property (nonatomic, strong) WDLoginEditView *phoneView;
@property (nonatomic, strong) WDLoginEditView *authCodeView;
@property (nonatomic, strong) WDLoginEditView *regPasswordView;
@property (nonatomic, strong) WDLoginEditView *confirmPasswordView;
@property (nonatomic, strong) WDLoginEditView *usernameView;
@property (nonatomic, strong) WDLoginEditView *passwordView;
@end

@implementation WDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [_phoneView.inputView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupView
{
    self.title = @"注册";
    
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
    
    // 密码
    _regPasswordView = [[WDLoginEditView alloc] initWithEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15) button:nil];
    _regPasswordView.nameLabel.text = @"密码";
    _regPasswordView.inputView.placeholder = @"输入密码";
    _regPasswordView.inputView.secureTextEntry = YES;
    [_registerView addSubview:_regPasswordView];
    
    // 确认
    _confirmPasswordView = [[WDLoginEditView alloc] initWithEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15) button:nil];
    _confirmPasswordView.nameLabel.text = @"确认";
    _confirmPasswordView.inputView.placeholder = @"确认密码";
    _confirmPasswordView.inputView.secureTextEntry = YES;
    [_registerView addSubview:_confirmPasswordView];
    
    // 注册按钮
    UIButton *registerButton = [UIButton new];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setBackgroundColor:WDThemeColor forState:UIControlStateNormal];
    [registerButton setBackgroundColor:RGB(29, 120, 211) forState:UIControlStateHighlighted];
    [registerButton.layer setMasksToBounds:YES];
    [registerButton.layer setCornerRadius:5.0];
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
            self.title = @"登录";
            _registerView.frame = CGRectMake(-viewSize.width, 0, viewSize.width, viewSize.height);
            _loginView.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
        } completion:^(BOOL finished) {
            _registerView.hidden = YES;
            [_usernameView.inputView becomeFirstResponder];
        }];
    }];
    
    ///////////////////登录view
    _loginView = [[UIView alloc] initWithFrame:CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height)];
    _loginView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_loginView];
    
    // 注册提示信息
    WDLabelView *loginInfoView = [[WDLabelView alloc] initWithEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    loginInfoView.label.text = @"用手机号/账号登录";
    [_loginView addSubview:loginInfoView];
    
    // 用户名
    _usernameView = [[WDLoginEditView alloc] initWithEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15) button:nil];
    _usernameView.nameLabel.text = @"账号";
    _usernameView.inputView.placeholder = @"输入手机号/账号";
    [_loginView addSubview:_usernameView];
    
    // 密码
    _passwordView = [[WDLoginEditView alloc] initWithEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 15) button:nil];
    _passwordView.nameLabel.text = @"密码";
    _passwordView.inputView.placeholder = @"输入密码";
    _passwordView.inputView.secureTextEntry = YES;
    [_loginView addSubview:_passwordView];
    
    // 登录按钮
    UIButton *loginButton = [UIButton new];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setBackgroundColor:WDThemeColor forState:UIControlStateNormal];
    [loginButton setBackgroundColor:RGB(29, 120, 211) forState:UIControlStateHighlighted];
    [loginButton.layer setMasksToBounds:YES];
    [loginButton.layer setCornerRadius:5.0];
    [loginButton addTarget:self action:@selector(tapLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    [_loginView addSubview:loginButton];
    
    // 切换按钮
    UIButton *switchToRegisterButton = [[UIButton alloc] init];
    switchToRegisterButton.backgroundColor = [UIColor clearColor];
    [switchToRegisterButton setTitle:@"用密码登录" forState:UIControlStateNormal];
    [switchToRegisterButton setTitleColor:WDThemeColor forState:UIControlStateNormal];
    [switchToRegisterButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_loginView addSubview:switchToRegisterButton];
    [switchToRegisterButton addAction:^(UIButton *btn) {
        _registerView.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.title = @"注册";
            _registerView.frame = CGRectMake(0, 0, viewSize.width, viewSize.height);
            _loginView.frame = CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height);
        } completion:^(BOOL finished) {
            [_phoneView.inputView becomeFirstResponder];
        }];
    }];
    
    
    // 点击手势
    UITapGestureRecognizer *singleRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [_registerView addGestureRecognizer:singleRecognizer1];
    UITapGestureRecognizer *singleRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [_loginView addGestureRecognizer:singleRecognizer2];
    
    
    // 设置自动布局
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
    
    _regPasswordView.sd_layout
    .topSpaceToView(_authCodeView, 0)
    .leftEqualToView(_registerView)
    .rightEqualToView(_registerView).heightIs(45);
    
    _confirmPasswordView.sd_layout
    .topSpaceToView(_regPasswordView, 0)
    .leftEqualToView(_registerView)
    .rightEqualToView(_registerView).heightIs(45);
    
    registerButton.sd_layout
    .leftSpaceToView(_registerView, 15)
    .rightSpaceToView(_registerView, 15)
    .topSpaceToView(_confirmPasswordView, 37)
    .heightIs(37);
    
    switchToLoginButton.sd_layout.rightSpaceToView(_registerView, 15).topSpaceToView(registerButton, 20);
    [switchToLoginButton setupAutoSizeWithHorizontalPadding:0 buttonHeight:20];
    
    loginInfoView.sd_layout
    .topSpaceToView(_loginView, 64)
    .leftEqualToView(_loginView)
    .rightEqualToView(_loginView)
    .heightIs(37);
    
    _usernameView.sd_layout
    .topSpaceToView(loginInfoView, 0)
    .leftEqualToView(_loginView)
    .rightEqualToView(_loginView).heightIs(45);
    
    _passwordView.sd_layout
    .topSpaceToView(_usernameView, 0)
    .leftEqualToView(_loginView)
    .rightEqualToView(_loginView).heightIs(45);
    
    loginButton.sd_layout
    .leftSpaceToView(_loginView, 15)
    .rightSpaceToView(_loginView, 15)
    .topSpaceToView(_passwordView, 37)
    .heightIs(37);
    
    switchToRegisterButton.sd_layout.rightSpaceToView(_loginView, 15).topSpaceToView(loginButton, 20);
    [switchToRegisterButton setupAutoSizeWithHorizontalPadding:0 buttonHeight:20];
}

- (void)tapRegisterBtn
{
    NSString *phone_number = _phoneView.inputView.text;
    if (![Utils checkTelNumber:phone_number])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号" duration: 0.5];
        [_phoneView.inputView becomeFirstResponder];
        return;
    }
    NSString *pass = _regPasswordView.inputView.text;
    NSString *confirm = _confirmPasswordView.inputView.text;
    if (![pass isEqualToString:confirm])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入相同的密码" duration: 0.5];
        _confirmPasswordView.inputView.text = @"";
        [_confirmPasswordView.inputView becomeFirstResponder];
        return;
    }
    if (![Utils checkPassword:pass])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入6-18位的密码" duration: 0.5];
        _regPasswordView.inputView.text = @"";
        _confirmPasswordView.inputView.text = @"";
        [_regPasswordView.inputView becomeFirstResponder];
        return;
    }
    CocoaSecurityResult *md5 = [CocoaSecurity md5:pass];
    pass = md5.hex;
    
    WeakSelf
    NSDictionary *params = @{@"phone_number": phone_number, @"password": pass};
    [WDNetOperation postRequestWithURL:@"/users/register" parameters:params success:^(id responseObject) {
        NSDictionary *dict = (NSDictionary*)responseObject;
        NSLog(@"%@", dict);
        if ([dict[@"code"] intValue] == 200)
        {
            NSDictionary *content = dict[@"content"];
            [WDUserDefaults setObject:content[@"_id"] forKey:kUserID];
            [WDUserDefaults setObject:content[@"username"] forKey: kUserName];
            [WDUserDefaults setObject: content forKey: kUserModel];
            [WDUserDefaults synchronize];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }
        else if ([dict[@"code"] intValue] == 500)
        {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"] duration: 1.5];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"注册失败,请稍后再试" duration: 1.5];
    }];
}

- (void)tapLoginBtn
{
    NSString *phone_number = _usernameView.inputView.text;
    if (![Utils checkTelNumber:phone_number])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号" duration: 0.5];
        [_usernameView.inputView becomeFirstResponder];
        return;
    }
    NSString *pass = _passwordView.inputView.text;
    if (![Utils checkPassword:pass])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入6-18位的密码" duration: 0.5];
        _passwordView.inputView.text = @"";
        [_regPasswordView.inputView becomeFirstResponder];
        return;
    }
    CocoaSecurityResult *md5 = [CocoaSecurity md5:pass];
    pass = md5.hex;
    
    WeakSelf
    NSDictionary *params = @{@"phone_number": phone_number, @"password": pass};
    [WDNetOperation postRequestWithURL:@"/users/login" parameters:params success:^(id responseObject) {
        NSDictionary *dict = (NSDictionary*)responseObject;
        //        NSLog(@"%@", dict);
        if ([dict[@"code"] intValue] == 200)
        {
            NSDictionary *content = dict[@"content"];
            [WDUserDefaults setObject:content[@"_id"] forKey:kUserID];
            [WDUserDefaults setObject:content[@"username"] forKey: kUserName];
            [WDUserDefaults setObject: content forKey: kUserModel];
            [WDUserDefaults synchronize];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        }
        else if ([dict[@"code"] intValue] == 500)
        {
            [SVProgressHUD showErrorWithStatus:dict[@"msg"] duration: 1.5];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"登录失败,请稍后再试" duration: 1.5];
    }];
}

- (void)singleTap: (id)sender
{
    UIView * firstResponder = [Utils findFirstResponder:self.view];
    [firstResponder resignFirstResponder];
}

@end
