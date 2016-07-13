//
//  Utils.m
//  Everything
//
//  Created by Louis on 16/7/12.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (UIView *) findFirstResponder:(UIView *) _view
{
    UIView *retorno;
    for (id subView in _view.subviews)
    {
        if ([subView isFirstResponder])
            return subView;
        
        if ([subView isKindOfClass:[UIView class]])
        {
            UIView *v = subView;
            if ([v.subviews count] > 0)
            {
                retorno = [self findFirstResponder:v];
                if ([retorno isFirstResponder])
                {
                    return retorno;
                }
            }
        }
    }
    return retorno;
}

#pragma 正则匹配手机号

+ (BOOL)checkTelNumber:(NSString*) telNumber

{
    NSString *pattern =@"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:telNumber];
}

#pragma 正则匹配用户密码6-18位数字和字母组合

+ (BOOL)checkPassword:(NSString*) password
{
    NSString *pattern =@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    return [pred evaluateWithObject:password];
    
}

#pragma 正则匹配用户姓名,20位的中文或英文

+ (BOOL)checkUserName : (NSString*) userName
{
    NSString *pattern =@"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    return [pred evaluateWithObject:userName];
    
}

#pragma 正则匹配用户身份证号15或18位

+ (BOOL)checkUserIdCard: (NSString*) idCard
{
    NSString *pattern =@"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:idCard];
}

#pragma 正则匹员工号,12位的数字

+ (BOOL)checkEmployeeNumber : (NSString*) number
{
    NSString *pattern =@"^[0-9]{12}";
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    return [pred evaluateWithObject:number];
}

#pragma 正则匹配URL

+ (BOOL)checkURL : (NSString*) url
{
    NSString*pattern =@"^[0-9A-Za-z]{1,50}";
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [pred evaluateWithObject:url];
}

@end
