//
//  WDUserModel.m
//  Everything
//
//  Created by Louis on 16/7/10.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDUserModel.h"

@implementation WDUserModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_head_image forKey:@"head_image"];
    [aCoder encodeInteger:_gender forKey:@"gender"];
    [aCoder encodeObject:_create_date forKey:@"create_date"];
    [aCoder encodeObject:_phone_number forKey:@"phone_number"];
    [aCoder encodeInteger:_userid forKey:@"userid"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.head_image = [aDecoder decodeObjectForKey:@"head_image"];
        self.gender = [aDecoder decodeIntegerForKey:@"gender"];
        self.head_image = [aDecoder decodeObjectForKey:@"create_date"];
        self.gender = [aDecoder decodeIntegerForKey:@"userid"];
        self.head_image = [aDecoder decodeObjectForKey:@"phone_number"];
    }
    return self;
}

@end
