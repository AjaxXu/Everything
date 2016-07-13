//
//  WDUserModel.h
//  Everything
//
//  Created by Louis on 16/7/10.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDUserModel : NSObject<NSCoding>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, strong) NSString *head_image;
@property (nonatomic, strong) NSString *create_date;
@property (nonatomic, strong) NSString *phone_number;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *autograph;

@end
