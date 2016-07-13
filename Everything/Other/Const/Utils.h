//
//  Utils.h
//  Everything
//
//  Created by Louis on 16/7/12.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Utils : NSObject

#pragma 在View中找到FirstResponder 的子view
+ (UIView *) findFirstResponder:(UIView *) _view;

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString*) telNumber;

#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString*) password;

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString*) userName;

#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString*) idCard;

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString*) number;

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString*) url;

@end
